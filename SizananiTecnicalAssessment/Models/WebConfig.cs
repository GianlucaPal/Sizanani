using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace SizananiTecnicalAssessment.Models
{
    public class WebConfig
    {
        public static string ConnectionString
        {
            get
            {
                // Return the Cached Connection String
                return WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;
            }
        }
    }
}