using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using OscarServer.Models;
using OscarServer.Helpers;

namespace OscarServer
{
    public class RentalsController : ControllerBase
    {
        [ActionName("")]
        public Rental Get(int id)
        {
            return new RentalCollection(new RentalQuery { RentalID = id }).First();
        }

        [ActionName("")]
        public void Post([FromBody]BaseRental value)
        {
            Item item = new ItemCollection(new ItemQuery { ItemID = value.ItemID }).First();
            Movie movie = new MovieCollection(new MovieQuery { MovieID = item.MovieID }).First();

            Rental created = new Rental()
            {
                ItemID = item.ItemID,
                MemberID = value.MemberID,
                RentalDate = DateTime.Now,
                RentalModeID = movie.RentalModeID,
                RentalState = value.RentalState
            };
            created.GenerateKey();
            created.Save();
        }

        [ActionName("")]
        public void Put(int id, [FromBody]BaseRental value)
        {
            Rental existing = this.Get(id);
            if (existing == null)
                throw new KeyNotFoundException();
            else if (value.ReturnState.HasValue) // item is being returned
            {
                existing.ReturnState = value.ReturnState;
                existing.ReturnDate = DateTime.Now;
                existing.Save();
            }
        }
    }
}
