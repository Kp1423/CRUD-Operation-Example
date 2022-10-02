using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DevItPractical
{
    public class Helper
    {

        string sqlConnStr = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
        private SqlConnection _sqlCon;
        public SqlDataReader dr;
        private SqlCommand sqlCmd = new SqlCommand();

        public SqlConnection sqlCon
        {
            get
            {
                if (_sqlCon == null)
                {
                    _sqlCon = new SqlConnection(sqlConnStr);
                }
                return _sqlCon;
            }
        }

        public bool Open()
        {
            if (sqlCon.State == ConnectionState.Closed)
            {
                sqlCon.Open();//Start connection 
                return true;
            }
            return false;
        }

        public void Close()
        {
            if (sqlCon.State == ConnectionState.Open)
            {
                sqlCon.Close();//Close connection 
            }
        }

        public DataTable ExecuteQuery(string storedProcedure)
        {
            DataTable dt = new DataTable();
            Open();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sqlAdapt = new SqlDataAdapter(storedProcedure, sqlCon);

            sqlAdapt.Fill(dt);
            sqlCon.Close();
            return dt;
        }

        public void InsertIntoTable(string storedProcedure, List<string> parameters, List<object> values)
        {
            Open();

            sqlCmd = new SqlCommand(storedProcedure, sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            for (int i = 0; i < parameters.Count; i++)
            {
                sqlCmd.Parameters.AddWithValue(parameters[i], values[i]);
            }
            
            sqlCmd.ExecuteNonQuery();
        }


        public void DeleteOrUpdate(string storedProcedure, List<string> parameters, List<object> values)
        {
            Open();
            sqlCmd = new SqlCommand(storedProcedure, sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            for (int i = 0; i < parameters.Count; i++)
            {
                sqlCmd.Parameters.AddWithValue(parameters[i], values[i]);
            }
            sqlCmd.ExecuteNonQuery();
        }

    }

    public class CustDetails
    {
        
    }

}