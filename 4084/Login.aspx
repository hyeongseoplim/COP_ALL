<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Jinhak.SRSAdmin._4084_Login" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>서일대 통계 조회</title>
	<link rel="stylesheet" href="common.css" type="text/css" />
	<script src="../_Inc/js/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="../_Inc/js/jquery.cookie.js" type="text/javascript"></script>
	<script type="text/javascript">
	<!--
	function Login(){
		if($("input#AdminID").val() == ""){
			alert("아이디를 입력해 주세요");
			$("input#AdminID").focus();
		}
		else if($("input#AdminPW").val() == ""){
			alert("비밀번호를 입력해 주세요");
			$("input#AdminPW").focus();
		}
		else{
			$("#LoginBtn").click();
		}
	}
		
	var SaveId = $.cookie('JINHAKN_4084_SAVEID');
    SaveId = (SaveId != null) ? SaveId.replace("AdminId=", "") : SaveId;
	$(document).ready(function(){
		$("input").bind({
			"keypress":function(event){
				if(event.keyCode == 13) Login();
			}
		});

		if(SaveId == null || SaveId == ""){
			$("input#AdminID").focus();
		}
		else{
			$("input#AdminID").val(SaveId);
			$('#SaveId').attr('checked', 'checked');
			$("input#AdminPW").focus();
		}
        
		if (location.hostname.toLowerCase().indexOf("localpimsadmin") > -1) {
		    $("input#AdminID").val("seoil");
		    $("input#AdminPW").val("seoil");
		    Login();
		}
	});

	//-->
	</script>
</head>
<form id="form1" runat="server">
<body class="body_pw">
    
    <!-- header -->
    <div id="header">
	    <!-- logo -->
	    <h1><span>서일대 통계</span></h1>	
	    <!-- //logo -->
    </div>
    <!-- //header -->

    <!-- wrap_pw -->
    <div id="wrap_pw">
	    <!-- cont_pw_in -->
	    <div class="cont_pw_in">
    		
		    <!-- form -->
		    <div class="box_round outer mT20">
			    <div class="inner" style="text-align:left;background:url(Img/top_img.png) no-repeat -30px 80px;">
				    <table class="tbl_login" style="width:65%;height:300px;">
				    <colgroup>
					    <col width="30%" />
					    <col width="50%" />
					    <col width="20%" />
				    </colgroup>
				    <tr>
				        <th style="height:80px;">&nbsp;</th>
				    </tr>
				    <tr>
					    <th style="background-color:#FFFFFF;text-align:right;padding-right:10px;"><img src="Img/ico_circle.png" />아이디</th>
					    <td style="background-color:#FFFFFF;">
                            <input type="text" style="display:none;" autocomplete="off" />
                            <input type="text" id="AdminID" name="AdminID" tabIndex="1" style="ime-mode:disabled;" runat="server" autocomplete="off" />
					    </td>
					    <td style="background-color:#FFFFFF;" rowspan="2" width="90"><img src="Img/btn_submit.gif" width="78" height="64" alt="확인" style="cursor:pointer;cursor:hand;" onclick="Login()" /></td>
				    </tr>
				    <tr>
					    <th style="background-color:#FFFFFF;text-align:right;padding-right:10px;"><img src="img/ico_circle.png" />비밀번호</th>
					    <td style="background-color:#FFFFFF;">
                            <input type="password" style="display:none;" autocomplete="off" />
                            <input type="text" id="AdminPW" name="AdminPW" tabIndex="2" runat="server" autocomplete="off" />
					    </td>
				    </tr>
				    <tr>
					    <th style="background-color:#FFFFFF;">&nbsp;</th>
					    <td style="background-color:#FFFFFF;"><input id="SaveId" name="SaveId" type="checkbox" runat="server" tabindex="3" value="Save" style="border:0px;" /><img src="img/login_save_01.gif" alt="아이디 저장" onclick="$('#SaveId').attr('checked', ($('#SaveId').attr('checked')) ? '' : 'checked' );" style="cursor:pointer;cursor:hand;" /></td>
					    <td style="background-color:#FFFFFF;"></td>
				    </tr>
				    <tr>
				        <th style="height:57px;">&nbsp;</th>
				    </tr>
				    </table>
			    </div>
		    </div>
		    
		    <div style="display:none;">
		        <asp:Button ID="LoginBtn" runat="server" OnClick="Login_4084" />
		    </div>
		    
		    
		    <!-- //form -->
	    </div>
	    <!-- //cont_pw_in -->
    </div>
    <!-- //wrap_pw -->

</body>
</form>
</html>
