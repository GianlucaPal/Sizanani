using SizananiTecnicalAssessment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SizananiTecnicalAssessment
{
    public partial class RegisterContractor : Page
    {

        internal UserEntry currentUserEntry
        {
            get { return (ViewState["UserEntry"] == null ? new UserEntry() : (UserEntry)ViewState["UserEntry"]); }
            set { ViewState["UserEntry"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                currentUserEntry = new UserEntry();
            }
        }

        #region Methods 
        public void PopulateObject()
        {
            currentUserEntry.UserName = txtUserName.Text;
            currentUserEntry.Email = txtEmail.Text;
            currentUserEntry.FirstName = txtFirstName.Text;
            currentUserEntry.LastName = txtLastName.Text;
            currentUserEntry.Phone = txtPhone.Text;
            currentUserEntry.Password = txtPassword.Text;
        }

        private bool ValidatePasswords()
        {
            bool _returnValue = false;
            if(txtConfirmPassword.Text == txtPassword.Text)
            {
                _returnValue = true;
            }
            
            return _returnValue;
        }
        #endregion Methods 

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if(ValidatePasswords())
            {
                try
                {
                    PopulateObject();
                    if (currentUserEntry.Save())
                    {
                        Response.Redirect($"~/Default.aspx?Login={Helpers.Encrypt(currentUserEntry.UserID)}");
                    }
                }
                 catch(Exceptions.ValidationException ex)
                {
                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('" + ex.Message + "');", true);
                }
            }
        }
    }
}