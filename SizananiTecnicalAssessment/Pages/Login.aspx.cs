using SizananiTecnicalAssessment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SizananiTecnicalAssessment
{
    public partial class Login : Page
    {
        internal UserEntry currentUserEntry
        {
            get { return (ViewState["UserEntry"] == null ? new UserEntry() : (UserEntry)ViewState["UserEntry"]); }
            set { ViewState["UserEntry"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                currentUserEntry = new UserEntry();
                Session["IsLoggedIn"] = false;
            }
            
        }

        #region Methods 
        public void PopulateObject()
        {
            currentUserEntry.UserName = txtUserName.Text;
            currentUserEntry.Password = txtPassword.Text;
        }

        #endregion Methods 

        protected void btnLogin_Click(object sender, EventArgs e)
        {
           PopulateObject();
            try
            {
                if (currentUserEntry.ValidateUserLogin())
                {
                    Session["IsLoggedIn"] = true;
                    Session["UserID"] = Helpers.Encrypt(currentUserEntry.UserID);
                    Response.Redirect($"~/Default.aspx");
                }
            }
            catch (Exceptions.ValidationException ex) 
            {
                //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('" + ex.Message + "');", true);
                lblLoginError.Text= ex.Message;
                lblLoginError.Visible= true;
            }
        }
    }
}