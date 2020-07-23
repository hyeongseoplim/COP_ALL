<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistStatR.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RegistStatR" %>
<!DOCTYPE html>
<html>
<head>
    <title>서일대</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/4084.css" rel="stylesheet" />
</head>
<body>
<!--#include file="Header.html"-->
<div id="Stat" style="text-align:left;margin-bottom:200px;">
<div v-if="Loading" style="position:absolute;top:0px;left:0px;width:100%;height:2000px;text-align:center;
filter:alpha(opacity=50);opacity:0.5;background-color:#CCCCCC;z-index:1;">
    <img src="/Admin/_Inc/CommonImg/SaveLoading.gif" alt="SaveLoading" style="margin-top:200px;" />
</div>


    <!-- 5. 등록 현황 -->
    <div v-show="!Loading" style='display:none;'>
        <h2 style="text-align:center;">{{GetTitle}} 등록현황 (신입학)</h2>
        
        <h5 style="float:left;">
            <div class="fl mid">등록일자 : </div>
            <vuejs-datepicker :format='customFormatter' v-model='NowDate' :typeable="true" wrapper-class="fl" input-class="tc"></vuejs-datepicker>
        </h5>
        <table id="Content" class="table table-bordered table-condensed">
        <colgroup>
            <col width="*" />
            
            <col width="8%" />
            
            <col width="8%" />
            <col width="8%" />
            <col width="8%" />
            <col width="8%" />
            <col width="8%" />
            <col width="8%" />
            <col width="15%" />
        </colgroup>
        <thead>
        <tr class="active">
            <th rowspan='2' style='text-align:center;'>구분</th>
            <th rowspan='2' style='text-align:center;'>모집구분</th>
            <th rowspan='2' style='text-align:center;'>정원</th>
            <th rowspan='2' style='text-align:center;'>전일누계</th>
            <th colspan='2' style='text-align:center;'>금일등록</th>
            <th rowspan='2' style='text-align:center;'>계</th>
            <th rowspan='2' style='text-align:center;'>결원</th>
        </tr>
        <tr class="active">
            <th style='text-align:center;'>예치</th>
            <th style='text-align:center;'>완납</th>
        </tr>
        </thead>
        <tbody v-for="(iot, io) in IO">
        <tr v-for="(service,id) in Service">
            <th class="active tc vc" :rowspan="Service.length" v-if="id == 0">{{iot}}</th>
            <td>{{service.ServiceName}}</td>
            <th class='Cnt'>{{GetRecruitPersonnel(io, service) | digit}}</th>
            <td class='Cnt'>{{GetPrevAccum(io, service).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(io, service, R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(io, service, R.Row1).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(io, service).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{0 | digit}}</td>
        </tr>
        <tr class="active">
            <th colspan='2' style='text-align:center;'>{{iot}} 소계</th>
            <th class='Cnt'>{{GetRecruitPersonnel(io) | digit}}</th>
            <td class='Cnt'>{{GetPrevAccum(io).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(io, undefined, R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(io, undefined, R.Row1).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(io).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{0 | digit}}</td>
        </tr>
        </tbody>
        <tfoot>
        <tr class="active">
            <td colspan='2' style='text-align:center;'>합계</td>
            <th class='Cnt'>{{GetRecruitPersonnel() | digit}}</th>
            <td class='Cnt'>{{GetPrevAccum().Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(undefined, undefined, R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay(undefined, undefined, R.Row1).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowPay().Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{0 | digit}}</td>
        </tr>
        </tfoot>
        </table>
    </div>

</div>

<script type="text/javascript" src="/Admin/_inc/js/jquery.min.js"></script>
<script type="text/javascript" src="/Admin/_inc/js/Common.js"></script>
<script type="text/javascript" src="js/moment.js"></script>
<script type="text/javascript" src="js/lodash.js"></script>
<script type="text/javascript" src="js/vue.js"></script>
<script type="text/javascript" src="js/vuejs-datepicker.min.js"></script>
<script type="text/javascript" src="js/4084.js"></script>
<script type="text/javascript" src="js/RegistStatR.js"></script>
</body>
</html>