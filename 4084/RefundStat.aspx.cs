using System;
using System.Configuration;
using System.Data;
using System.Web;
using Jinhak.SRSAdmin;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace Jinhak.SRSAdmin_4084
{
    public partial class _4084_RefundStat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Common4084.getCookieAdminId_4084() == string.Empty)
            {
                Response.Redirect("Login.aspx");
                Response.End();
            }
        }

        [WebMethod]
        public static string GetStatistics()
        {
            string returnJSON = string.Empty;
            SqlParameter[] parameters = { 
		        new SqlParameter("@UnivID", 4084)
	        };
            using (DataSet ds = SqlHelper.ExecuteDataset(Common4084.CONN, CommandType.StoredProcedure, "dbo.PIMS_STATISTICS_REFUND_4084", parameters))
            {
                returnJSON = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
            }
            return returnJSON;
        }

    }
}