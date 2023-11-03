using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Microsoft.Ajax.Utilities;
using System.Collections.ObjectModel;
using System.Drawing;

namespace SizananiTecnicalAssessment.Models
{
    [Serializable]
    public class UserEntry
    {

        #region Properties

        public string UserID { get; set; }
        public string FirstName { get; set; }
        public string LastName{ get; set; }
        public string FullName{ get; set; }
        public string UserName{ get; set; }
        public string Password{ get; set; }
        public string Phone{ get; set; }
        public string Email{ get; set; }

        #endregion Properties

        #region Constructors

        public UserEntry() { } 
        public UserEntry(string userID)
        {
            this.UserID = userID;

            RefreshObject();
        }

        #endregion Constructors

        #region Methods

        #region Refresh Object 
        /// <summary>
        /// method to populate object from db when diven the userID(called in constructor)
        /// </summary>
        private void RefreshObject()
        {
            if (!string.IsNullOrEmpty(UserID))
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spUser_List", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@UserID", UserID);
                            cn.Open();
                            using (SqlDataReader rd = cm.ExecuteReader())
                            {
                                while (rd.Read())
                                {
                                    //Area - Your Details
                                    FullName = rd["FullName"].ToString();
                                    FirstName = rd["FirstName"].ToString();
                                    LastName = rd["LastName"].ToString();
                                    UserName = rd["UserName"].ToString();
                                    Email = rd["Email"].ToString();
                                    Phone = rd["Phone"].ToString();
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                }
            }
        
        }
        #endregion Refresh Object 

        #region Save
        /// <summary>
        ///  generic save method to update and insert
        /// </summary>
        /// <returns> boolean to indicate if save was successful</returns>
        public bool Save()
        {
            bool _returnValue = false;

            if (string.IsNullOrEmpty(UserID))//Will Add New Entry
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spUser_Insert", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@FirstName", FirstName);
                            cm.Parameters.AddWithValue("@LastName", LastName);
                            cm.Parameters.AddWithValue("@UserName", UserName);
                            cm.Parameters.AddWithValue("@Password", Helpers.Encrypt(Password));
                            cm.Parameters.AddWithValue("@Phone", Phone);
                            cm.Parameters.AddWithValue("@Email", Email);

                            cm.Parameters.Add("@UserID", SqlDbType.UniqueIdentifier).Direction = ParameterDirection.Output;

                            cn.Open();
                            cm.ExecuteNonQuery();
                            //Successful Insert 
                            if (cm.Parameters["@UserID"].Value != null)
                            {
                                UserID = cm.Parameters["@UserID"].Value.ToString();
                                _returnValue = true;
                            }
                            else
                            {
                                _returnValue = false;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                }
            }
            else if (!string.IsNullOrEmpty(UserID))//Will Update an Existing User Based on UserID given
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spUser_Update", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@UserID", UserID);
                            cm.Parameters.AddWithValue("@FirstName", FirstName);
                            cm.Parameters.AddWithValue("@LastName", LastName);
                            cm.Parameters.AddWithValue("@UserName", UserName);
                            cm.Parameters.AddWithValue("@Password", Password);
                            cm.Parameters.AddWithValue("@Phone", Phone);
                            cm.Parameters.AddWithValue("@Email", Email);
                            cn.Open();
                            cm.ExecuteNonQuery();
                            //Successful Update 
                            _returnValue = true;
                        }
                    }
                }
                catch (Exception ex)
                {
                }
            }
            return _returnValue;
        }

        #endregion Save

        #region Validation 
        public bool Validation()
        {
            bool _returnValue = false;
            if (string.IsNullOrEmpty(FirstName))
                if (string.IsNullOrEmpty(LastName))
                    if (string.IsNullOrEmpty(UserName))
                        if (string.IsNullOrEmpty(Phone))
                            if (string.IsNullOrEmpty(Email))
                                if (string.IsNullOrEmpty(Password))
                                    _returnValue = true;
                                else
                                {
                                    throw new Exceptions.ValidationException("Enter Password");
                                }
                            else
                            {
                                throw new Exceptions.ValidationException("Enter Email");
                            }
                        else
                        {
                            throw new Exceptions.ValidationException("Enter Phone Number");
                        }
                    else
                    {
                        throw new Exceptions.ValidationException("Enter User Name");
                    }
                else 
                {
                    throw new Exceptions.ValidationException("Enter Last Name");
                }
            else
            {
                throw new Exceptions.ValidationException("Enter First Name");
            }

            return _returnValue;
        }
        #endregion Validation 

        #region Validate User Login

        public bool ValidateUserLogin() 
        {
            bool _returnValue = false;

            if (!string.IsNullOrEmpty(UserName))
            {
                if (!string.IsNullOrEmpty(Password))
                {
                    try
                    {
                        using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                        {
                            using (SqlCommand cm = new SqlCommand("spGetUserLogins", cn))
                            {
                                cm.CommandType = CommandType.StoredProcedure;
                                cm.Parameters.AddWithValue("@UserName", UserName);
                                cm.Parameters.AddWithValue("@Password", Helpers.Encrypt(Password));
                                cn.Open();
                                using (SqlDataReader rd = cm.ExecuteReader())
                                {
                                    while (rd.Read())
                                    {
                                        //Area - Your Details
                                        UserID = rd["UserID"].ToString();
                                        FullName = rd["FullName"].ToString();
                                        FirstName = rd["FirstName"].ToString();
                                        LastName = rd["LastName"].ToString();
                                        UserName = rd["UserName"].ToString();
                                        Email = rd["Email"].ToString();
                                        Phone = rd["Phone"].ToString();
                                    }

                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                    }

                    if (!string.IsNullOrEmpty(UserID))
                    {
                        _returnValue = true;
                    }
                    else
                    {
                        throw new Exceptions.ValidationException("Invalid Logins");
                    }
                }
            }



            return _returnValue;
        }
        #endregion Validate User Login


        #endregion Methods

    }
}