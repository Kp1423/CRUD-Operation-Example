using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DevItPractical
{
    public partial class AddUpdateOrder : System.Web.UI.Page
    {

        Helper _db = new Helper();
        SqlDataAdapter da = new SqlDataAdapter();
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BindItemList();
                if (Session["Add"].ToString() == "IsAdd")
                {
                    BtnAddUpdate.Text = "Add";
                    BtnReset.Visible = true;
                    ResetFields();
                }
                else if (Session["Add"].ToString() == "IsUpdate")
                {
                    BtnAddUpdate.Text = "Update";
                    BtnReset.Visible = false;
                    GetDataToUpdate();
                }
            }
        }

        protected void BindItemList()
        {
            txtItems.Items.Clear();
            DataTable dt = _db.ExecuteQuery("PR_GetItemList");
            txtItems.Items.Add("--Select Item--");
                
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                txtItems.Items.Add(dt.Rows[i].ItemArray[1].ToString());
            }
            txtItems.SelectedIndex = 0;
        }
        protected void ResetFields()
        {
            txtCustName.Text = string.Empty;
            txtOrderDate.Text = DateTime.Today.ToString("dd/MM/yyyy").ToString().Replace("-", "/");
            txtQuantity.Text = "0";
            txtItems.SelectedIndex = 0;
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            ResetFields();
        }

        protected void BtnAddUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (BtnAddUpdate.Text == "Add")
                {

                    if (txtCustName.Text.Trim().Length == 0 || txtQuantity.Text == "0" ||
                     txtItems.SelectedIndex == 0 || txtOrderDate.Text == "")
                    {
                        LblMsg.Text = "All fields are mandatory";
                        return;
                    }
                    _db.InsertIntoTable("PR_InsertOrder",
                        new List<string>() { "@CustName", "@ItemId", "@Quantity", "@OrderDate" },
                        new List<object>() { txtCustName.Text.Trim(), txtItems.SelectedIndex,
                        txtQuantity.Text, Convert.ToDateTime(txtOrderDate.Text.ToString())});
                    

                    ResetFields();
                    LblMsg.Text = "Order details added successfully";
                }

                else if (BtnAddUpdate.Text == "Update")
                {
                    _db.DeleteOrUpdate("PR_UpdateOrder",
                        new List<string>() { "@CustName", "@ItemId", "@OrderDate", "@Quantity", "CustId" },
                        new List<object>() { txtCustName.Text.Trim(), txtItems.SelectedIndex,
                         Convert.ToDateTime(txtOrderDate.Text.ToString()), txtQuantity.Text, 
                            Convert.ToInt32(Session["CustId"].ToString())});

                    ResetFields();
                    LblMsg.Text = "Order details updated successfully";
                    Response.Redirect("OrderList.aspx");
                }

            }
            catch (Exception ex)
            {
                LblMsg.Text = "Exception :" + ex.Message.ToString();
            }
        }
        protected void GetDataToUpdate()
        {
            var dr = (TableCellCollection)Session["dr"];
            txtCustName.Text = dr[1].Text;
            txtOrderDate.Text = Convert.ToDateTime(dr[2].Text).ToString("dd/MM/yyyy").Replace("-", "/");
            txtQuantity.Text = dr[5].Text;
            txtItems.SelectedValue = dr[3].Text;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderList.aspx");
        }
    }
}