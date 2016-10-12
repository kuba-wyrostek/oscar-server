using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using OscarServer.Helpers;

namespace OscarServer
{
    public class ControllerBase : ApiController
    {
        public ControllerBase()
        {
            DataContext.CreateContext();
        }
    }
}