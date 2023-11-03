using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Configuration;

namespace SizananiTecnicalAssessment.Models
{
    [Serializable]
    public class Vehicle
    {
        #region Properties
        public int VehicleID { get; set; }
        public string RegistrationNumber { get; set; }
        public decimal Weight { get; set; }
        public int TypeID { get; set; }
	    public string Type { get; set; }
	    public string Model { get; set; }
	    public string UserID { get; set; }

        #endregion Properties

        #region Constructors
        public Vehicle() { }

        public Vehicle(int vehicleID)
        {
            this.VehicleID = vehicleID;
            RefreshObject();
        }

        #endregion Constructors

        #region Methods

        #region RefreshObject

        /// <summary>
        /// method to populate object from db when diven the VehicleID (called in constructor)
        /// </summary>
        private void RefreshObject()
        {
            if (VehicleID > 0)
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spVehicles_ListByUser", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@VehicleID", VehicleID);
                            cn.Open();
                            using (SqlDataReader rd = cm.ExecuteReader())
                            {
                                while (rd.Read())
                                {
                                    //Area - Your Details
                                    RegistrationNumber = rd["RegistrationNumber"].ToString();
                                    UserID = rd["UserID"].ToString();
                                    Weight = decimal.Parse(rd["Weight"].ToString());
                                    TypeID = int.Parse(rd["TypeID"].ToString());
                                    Type = rd["Type"].ToString();
                                    Model = rd["Model"].ToString();
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

        #endregion RefreshObject

        #region Save
        /// <summary>
        ///  generic save method to update and insert
        /// </summary>
        /// <returns> boolean to indicate if save was successful</returns>
        public bool Save()
        {
            bool _returnValue = false;

            if (VehicleID == 0)//Will Add New Entry
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spVehicles_Insert", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@RegistrationNumber", RegistrationNumber);
                            cm.Parameters.AddWithValue("@Weight", Weight);
                            cm.Parameters.AddWithValue("@TypeID", TypeID);
                            cm.Parameters.AddWithValue("@Model", Model);
                            cm.Parameters.AddWithValue("@UserID", UserID);

                            cm.Parameters.Add("@VehicleID", SqlDbType.Int).Direction = ParameterDirection.Output;

                            cn.Open();
                            cm.ExecuteNonQuery();
                            //Successful Insert 
                            if (cm.Parameters["@VehicleID"].Value != null)
                            {
                                //VehicleID = int.Parse(cm.Parameters["@VehicleID"].Value.ToString());
                                VehicleID = Convert.ToInt32(cm.Parameters["@VehicleID"].Value);
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
            else if (VehicleID > 0)//Will Update an Existing Vehicle Based on VehicleID given
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spVehicles_Update", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@RegistrationNumber", RegistrationNumber);
                            cm.Parameters.AddWithValue("@Weight", Weight);
                            cm.Parameters.AddWithValue("@TypeID", TypeID);
                            cm.Parameters.AddWithValue("@Model", Model);
                            cm.Parameters.AddWithValue("@UserID", UserID);
                            cm.Parameters.AddWithValue("@VehicleID", VehicleID);
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

        #region Delete
        public static bool Delete(int vehicleID)
        {
            bool _returnValue = false;
            if (vehicleID > 0)//Will Delete an Existing Vehicle Based on VehicleID given
            {
                try
                {
                    using (SqlConnection cn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnString"].ConnectionString))
                    {
                        using (SqlCommand cm = new SqlCommand("spVehicles_Delete", cn))
                        {
                            cm.CommandType = CommandType.StoredProcedure;
                            cm.Parameters.AddWithValue("@VehicleID", vehicleID);
                            cn.Open();
                            cm.ExecuteNonQuery();
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
        #endregion Delete

        #region Validation
        public bool Validation()
        {
            bool _returnValue = false;

            if (string.IsNullOrEmpty(RegistrationNumber))
                if (string.IsNullOrEmpty(Model))
                    if (TypeID > 0)
                        if (Weight > 0)
                            _returnValue = true;
                        else
                        {
                            throw new Exceptions.ValidationException("Enter Weight");
                        }
                    else
                    {
                        throw new Exceptions.ValidationException("Select Vehicle Type");
                    }
                else
                {
                    throw new Exceptions.ValidationException("Enter Model");
                }
            else
            {
                throw new Exceptions.ValidationException("Enter Registration Number");
            }

            return _returnValue;
        }
        #endregion Validation

        #endregion Methods
    }
}