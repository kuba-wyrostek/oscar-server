using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OscarServer.Helpers;

namespace OscarServer.Models
{
    public class MovieQuery : EntityQuery
    {
        public int? MovieID { get; set; }

        public override string ToString()
        {
            return "(0 = 0)"
                + (this.MovieID.HasValue ? " and MovieID = " + this.MovieID.ToString() : "");
        }
    }

    public class MovieCollection : EntityCollection<Movie>
    {
        public MovieCollection(MovieQuery query = null)
            : base(query) { }

        protected override string GetSelectCommand()
        {
            return @"select MovieID, Title, ReleaseYear, Movies.CategoryID, Movies.RentalModeID,
                    CategoryName, RentalPrice, OverduePrice, Limit, MaximumDays, ModeName
                from Movies
                    inner join Categories
                    on Movies.CategoryID = Categories.CategoryID
                        inner join RentalModes
                        on Movies.RentalModeID  = RentalModes.RentalModeID
                            inner join dbo.EffectivePricing(null) as EffectivePricing
                            on Movies.RentalModeID = EffectivePricing.RentalModeID" +
                (this.query != null
                ? " where " + this.query.ToString()
                : "");
        }
    }

    public class BaseMovie : Entity
    {
    }

    public class Movie : BaseMovie
    {
        public const string EntityName = "Movies";

        [IsKey]
        public int MovieID { get; private set; }

        public string Title { get; set; }
        public int ReleaseYear { get; set; }
        public int CategoryID { get; set; }
        public int RentalModeID { get; set; }

        [Computed]
        public string CategoryName { get; private set; }
        [Computed]
        public decimal RentalPrice { get; private set; }
        [Computed]
        public decimal OverduePrice { get; private set; }
        [Computed]
        public int Limit { get; private set; }
        [Computed]
        public string ModeName { get; private set; }
        [Computed]
        public int MaximumDays { get; private set; }
    }
}