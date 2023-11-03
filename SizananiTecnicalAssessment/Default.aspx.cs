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
                if (Session["IsLoggedIn"] == null)
                {
                    Response.Redirect($"~/Pages/Login.aspx");
                }
                else if (bool.Parse(Session["IsLoggedIn"].ToString()) == false)
                {
                    Response.Redirect($"~/Pages/Login.aspx");
                }
                else
                {
                    hfUserID.Value = Helpers.Decrypt(Session["UserID"].ToString());
                }
            }
        }

        protected void btnAddVehicle_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Pages/Vehicles.aspx");
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            GridViewRow gvr = (GridViewRow)btnEdit.Parent.Parent;

            int VehicleID = int.Parse(gvVehicles.DataKeys[gvr.RowIndex].Value.ToString());

            Response.Redirect($"~/Pages/Vehicles.aspx?Vehicle={VehicleID}");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

            Button btnEdit = (Button)sender;
            GridViewRow gvr = (GridViewRow)btnEdit.Parent.Parent;

            if(Vehicle.Delete(int.Parse(gvVehicles.DataKeys[gvr.RowIndex].Value.ToString())))
            {
                gvVehicles.DataBind();
                upVehicles.Update();
            }


        }
    }
    
}