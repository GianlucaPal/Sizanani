using SizananiTecnicalAssessment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SizananiTecnicalAssessment
{
    public partial class Vehicles : Page
    {
        internal Vehicle currentVehicleEntry
        {
            get { return (ViewState["Vehicle"] == null ? new Vehicle() : (Vehicle)ViewState["Vehicle"]); }
            set { ViewState["Vehicle"] = value; }
        }

        internal UserEntry currentUserEntry
        {
            get { return (ViewState["UserEntry"] == null ? new UserEntry() : (UserEntry)ViewState["UserEntry"]); }
            set { ViewState["UserEntry"] = value; }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["IsLoggedIn"] == null)
                {
                    Response.Redirect($"~/Pages/Login.aspx");
                }
                else if (bool.Parse(Session["IsLoggedIn"].ToString()) == true)
                {
                    if((Request.QueryString["Vehicle"] != null)) // Existing Vhicle
                    {
                        currentVehicleEntry = new Vehicle(int.Parse(Request.QueryString["Vehicle"]));
                        PopulateControls();
                    }
                    else //New Vehicle
                    {
                        currentVehicleEntry = new Vehicle();
                        currentUserEntry = new UserEntry(Helpers.Decrypt(Session["UserID"].ToString()));
                        currentVehicleEntry.UserID = currentUserEntry.UserID;
                    }
                }
                else
                {
                    Response.Redirect($"~/Pages/Login.aspx");
                }

            }
        }

        #region Methods 
        public void PopulateObject()
        {
            currentVehicleEntry.RegistrationNumber = txtRegistrationNumber.Text;
            currentVehicleEntry.Weight = decimal.Parse(txtWeight.Text);
            currentVehicleEntry.TypeID = int.Parse(ddlType.SelectedValue);
            currentVehicleEntry.Model = txtModel.Text;
        }

        public void PopulateControls()
        {
            txtRegistrationNumber.Text = currentVehicleEntry.RegistrationNumber ;
            txtWeight.Text = currentVehicleEntry.Weight.ToString();
            ddlType.SelectedValue = currentVehicleEntry.TypeID.ToString();
            txtModel.Text = currentVehicleEntry.Model;
        }
        #endregion Methods     

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                PopulateObject();
                if (currentVehicleEntry.Save())
                {
                    Response.Redirect($"~/Default.aspx?");
                }
            }
            catch (Exceptions.ValidationException ex)
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('" + ex.Message + "');", true);
            }
        }

    }
}