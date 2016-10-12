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
    public class MembersController : ControllerBase
    {
        [ActionName("")]
        public IEnumerable<Member> Get()
        {
            return new MemberCollection();
        }

        [ActionName("")]
        public Member Get(int id)
        {
            return new MemberCollection(new MemberQuery { MemberID = id }).First();
        }

        [ActionName("")]
        public void Post([FromBody]BaseMember value)
        {
            Member created = new Member()
            {
                RegistrationDate = DateTime.Now
            };
            created.GenerateKey();
            created.CopyFrom(value);
            created.Save();
        }

        [ActionName("")]
        public void Put(int id, [FromBody]BaseMember value)
        {
            Member existing = this.Get(id);
            if (existing == null)
                throw new KeyNotFoundException();
            else
            {
                existing.CopyFrom(value);
                existing.Save();
            }
        }

        [HttpGet]
        [ActionName("Rentals")]
        public IEnumerable<Rental> Rentals(int id)
        {
            return new RentalCollection(new RentalQuery { MemberID = id });
        }
    }
}