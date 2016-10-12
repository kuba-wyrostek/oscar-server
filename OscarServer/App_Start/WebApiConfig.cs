using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace OscarServer
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.Routes.MapHttpRoute(
                name: "DetailsApi",
                routeTemplate: "api/{controller}/{id}/{action}",
                defaults: new { id = RouteParameter.Optional, action = "" },
                constraints: new { id = @"(|^[0-9])$", action = @"^(|rentals|items)$" }
            );
            /*
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional, action = "" },
                constraints: new { id = @"^(|[0-9]+)$" }
            );*/
        }
    }
}
