using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OscarServer.Helpers
{
    [AttributeUsage(AttributeTargets.Property, Inherited = true)]
    public class IsKeyAttribute : Attribute
    {
    }
}