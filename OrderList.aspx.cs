using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DevItPractical
{
    public partial class OrderList : System.Web.UI.Page
    {
        Helper _db = new Helper();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            Session.RemoveAll();
            DataTable dt = new DataTable(); 
            dt = _db.ExecuteQuery("PR_GetOrder");
            gvCust.DataSource = dt;
            gvCust.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Session["Add"] = "IsAdd";
            Response.Redirect("AddUpdateOrder.aspx");
        }

        protected void gvCust_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("editRecord"))
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int CustId = Convert.ToInt32(gvCust.DataKeys[index].Value.ToString());
                Session["Add"] = "IsUpdate";
                Session["CustId"] = CustId.ToString();
                Session["dr"] = gvCust.Rows[index].Cells;
                Response.Redirect("AddUpdateOrder.aspx");
            }
            if (e.CommandName.Equals("deleteRecord"))
            {
                _db.DeleteOrUpdate("PR_DeleteOrder", new List<string>() { "@CustId" },
                    new List<object>() { Convert.ToInt32(e.CommandArgument) });
                BindData();
            }
        }

    }
}