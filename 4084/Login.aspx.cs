using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

namespace Jinhak.SRSAdmin
{
    public partial class _4084_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AdminPW.Attributes["type"] = "password";
        }

        protected void Login_4084(object sender, EventArgs e)
        {
            Dictionary<string, string> loginIds = new Dictionary<string, string>();
            loginIds.Add("seoil", "seoil");  // 마스터

            string FirstPage = "RefundListAdd.aspx";
            string inAdminId = AdminID.Value;
            string inAdminPW = AdminPW.Value;
            bool isSaveId = SaveId.Checked;

            bool isLogin = false;
            string LoginPassword;
            StringBuilder sbScript = new StringBuilder();
            if (loginIds.TryGetValue(inAdminId, out LoginPassword))
            {
                if (inAdminPW == LoginPassword)
                {
                    isLogin = true;
                }
                else
                {
                    sbScript.AppendLine("<script type='text/javascript'>");
                    sbScript.AppendLine("   alert('아이디 또는 패스워드가 잘못되었습니다.\\n다시 확인해주세요.');");
                    sbScript.AppendLine("   location.replace('Login.aspx');");
                    sbScript.AppendLine("</script>");
                }
            }
            else
            {
                sbScript.AppendLine("<script type='text/javascript'>");
                sbScript.AppendLine("   alert('아이디 또는 패스워드가 잘못되었습니다.\\n다시 확인해주세요.');");
                sbScript.AppendLine("   location.replace('Login.aspx');");
                sbScript.AppendLine("</script>");
            }

            if (isLogin)
            {
                Common4084.setCookieValue_4084(inAdminId);
                Common4084.setSaveAdminId_4084(inAdminId, isSaveId);
                Response.Redirect(FirstPage);
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "LoginFail", sbScript.ToString());
            }
        }

    }
}