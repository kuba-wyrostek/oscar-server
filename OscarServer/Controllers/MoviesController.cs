using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using OscarServer.Helpers;
using OscarServer.Models;

namespace OscarServer
{
    public class MoviesController : ControllerBase
    {
        [ActionName("")]
        public IEnumerable<Movie> Get()
        {
            return new MovieCollection();
        }

        [ActionName("")]
        public Movie Get(int id)
        {
            return new MovieCollection(new MovieQuery { MovieID = id }).First();
        }

        [HttpGet]
        [ActionName("Items")]
        public IEnumerable<Item> Items(int id)
        {
            return new ItemCollection(new ItemQuery { MovieID = id });
        }
    }
}