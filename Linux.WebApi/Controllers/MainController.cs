using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Runtime.InteropServices;

namespace Linux.WebApi.Controllers
{
    public class MainController : Controller
    {
        // GET hello
        [HttpGet("hello")]
        public IActionResult HelloWorld()
        {
            string platform = "Other";
            bool isWindows = RuntimeInformation.IsOSPlatform(OSPlatform.Windows);

            if (isWindows)
            {
                platform = OSPlatform.Windows.ToString();
            }

            bool isLinux = !isWindows && RuntimeInformation.IsOSPlatform(OSPlatform.Linux);

            if (isLinux)
            {
                platform = OSPlatform.Linux.ToString();
            }

            return Ok(new { platform = platform });
        }
    }
}
