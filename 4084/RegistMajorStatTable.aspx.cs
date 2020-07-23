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
    public partial class _4084_RegistMajorStatTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (getCookieAdminId_4084() == string.Empty)
            {
                Response.Redirect("Login.aspx");
                Response.End();
            }
        }

        public static string getCookieAdminId_4084()
        {
            HttpContext _context = HttpContext.Current;
            HttpCookieCollection _Cookie = _context.Request.Cookies;
            string rtnValue = string.Empty;
            try
            {
                rtnValue = _Cookie["JINHAKN_4084"].ToString();
            }
            catch { }

            return HttpUtility.UrlDecode(rtnValue, System.Text.ASCIIEncoding.Default);
        }


        [WebMethod]
        public static string GetStatistics()
        {
            string returnJSON = string.Empty;
            SqlParameter[] parameters = { 
		        new SqlParameter("@UnivID", 4084)
	        };
            using (DataSet ds = SqlHelper.ExecuteDataset(SRSConfigManager.ConnectionString, CommandType.StoredProcedure, "dbo.PIMS_STATISTICS_4084_REGISTMAJORTABLE", parameters))
            {
                returnJSON = Newtonsoft.Json.JsonConvert.SerializeObject(ds);
            }
            return returnJSON;
        }

    }
}