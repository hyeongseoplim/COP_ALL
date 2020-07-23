<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StatReportTotal.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_StatReportTotal" %>
<!DOCTYPE html>
<html>
<head>
    <title>서일대</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/4084.css" rel="stylesheet" />
    <style>
    table th{
        text-align:center !important;
    }    
    </style>
    <script type="text/javascript">
        function GoToPage(Type)
        {
            document.getElementById("pages").src = Type+'.aspx';
        }     
    </script>
</head>
<body>
    <!--#include file="Header.html"-->
    <button type="button" class="btn" url="StatReportV2.aspx" onclick="GoToPage('StatReportV2')">신입학</button>
    <button type="button" class="btn" url="StatReportV4.aspx" onclick="GoToPage('StatReportV4')">산업체위탁</button>
    <button type="button" class="btn" url="StatReportV3.aspx" onclick="GoToPage('StatReportV3')">전공심화</button>
    <button type="button" class="btn" url="StatReportV5.aspx" onclick="GoToPage('StatReportV5')">편입학</button>
    
    <div id="iframediv">
        <iframe src="StatReportV2.aspx" width="100%" height="800" frameborder="0" id="pages" scrolling='yes' ></iframe>
    </div>
</body>
</html>