using SizananiTecnicalAssessment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SizananiTecnicalAssessment
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                if(Request.QueryString["Login"] == null)
                {
                    Response.Redirect($"~/Pages/Login.aspx");
                }
            }
        }

        protected void btnAddVehicle_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Pages/Vehicles.aspx?Login={Request.QueryString["Login"]}");
        }
    }
}