// Default URL for triggering event grid function in the local environment.
// http://localhost:7071/runtime/webhooks/EventGrid?functionName={functionname}
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Azure.EventGrid.Models;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using System.IO;
using Newtonsoft.Json.Linq;

namespace Xmi.Poc.EventGridStoragePoc
{
    public static class PackageSigningFunction
    {
        [FunctionName("PackageSigningFunction")]
        public static void Run(
            [EventGridTrigger]
            EventGridEvent eventGridEvent,
            [Blob("{data.url}", FileAccess.Read)]
            Stream rawBlob,
            // [Blob("signed-packages/{name}", FileAccess.Write)]
            // Stream signedBlob,
            ILogger log)
        {
            var storageEvent = ((JObject)eventGridEvent.Data).ToObject<StorageBlobCreatedEventData>();

            log.LogInformation($"Received a file from {storageEvent.Url}");
        }
    }
}
