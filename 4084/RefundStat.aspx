<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundStat.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RefundStat" %>
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
        <button type="button" class="btn" v-bind:class="Type === '' ? 'btn-info' : ''" v-on:click="Type=''">전체</button>
        <button type="button" class="btn" v-bind:class="Type === '0' ? 'btn-info' : ''" v-on:click="Type='0'">예치금</button>
        <button type="button" class="btn" v-bind:class="Type === '1' ? 'btn-info' : ''" v-on:click="Type='1'">본등록</button>
        <button type="button" class="btn" v-bind:class="Type === '11' ? 'btn-info' : ''" v-on:click="Type='11'">전공심화</button>
        <button type="button" class="btn" v-bind:class="Type === '21' ? 'btn-info' : ''" v-on:click="Type='21'">산업체위탁</button>
        <button type="button" class="btn" v-bind:class="Type === '31' ? 'btn-info' : ''" v-on:click="Type='31'">편입학</button>

        <div v-show="!Loading" style='display:none;'>

            <h2 style="text-align:center;">{{GetTitle}} 반환자 명단 (전체)</h2>
            <h5 style="float:left;">{{DisplayNowDate()}} 현재 반환기준</h5>
            <table id="Content" class="table table-bordered table-condensed">
            <thead>
            <tr class="active">
                <th>순번</th>
                <th>수험번호</th>
                <th>성명</th>
                <th>예치금</th>
                <th>입학금</th>
                <th>수업료</th>
                <th>국가장학금</th>
                <th>합계</th>
                <th>구분</th>
                <th>비고</th>
                <th>학생회비</th>
                <th>등록금 + 학생회비</th>
            </tr>
           </thead>
		    <tbody>
            <tr v-for="(d,index) in GetData">
                <td>{{index+1}}</td>
                <td>{{MajorById[d.MajorId].MajorName}}</td>
                <td>{{d.StuName}}</td>
                
                <td class='Cnt'>{{d.PreAmount | digit}}</td>
                <td class='Cnt'>{{d.EnterAmount | digit}}</td>
                <td class='Cnt'>{{d.Tuition | digit}}</td>
                <td class='Cnt'>{{d.ScholarShip | digit}}</td>
                <td class='Cnt'>{{d.PreAmount + d.EnterAmount + d.Tuition - d.ScholarShip | digit}}</td>
                <td class='Cnt'>{{d.RecruitTimeName}}</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>{{d.AddAmount | digit}}</td>
                <td class='Cnt'>{{d.PreAmount + d.EnterAmount + d.Tuition - d.ScholarShip + d.AddAmount | digit}}</td>
            </tr>
            <tr v-if="Data.length == 0">
                <td colspan="11" style='text-align:center;padding:30px;'>
                    등록자 명단 데이터가 없습니다.
                </td>
            </tr>
            </tbody>
            <tfoot>
            <tr class="active">
                <th colspan="3">
                    합계 <span style="float:right;margin-right:50px;">{{GetData.length}} 명</span>
                </th>
                <th class='Cnt'>{{GetData.Sum('PreAmount') | digit}}</th>
                <th class='Cnt'>{{GetData.Sum('EnterAmount') | digit}}</th>
                <th class='Cnt'>{{GetData.Sum('Tuition') | digit}}</th>
                <th class='Cnt'>{{GetData.Sum('ScholarShip') | digit}}</th>
                <th class='Cnt'>{{GetData.Sum('PreAmount') + GetData.Sum('EnterAmount') + GetData.Sum('Tuition') + GetData.Sum('ScholarShip') | digit}}</th>
                <th class='Cnt' colspan='2'>&nbsp;</th>
                <th class='Cnt'>{{GetData.Sum('AddAmount') | digit}}</th>
                <th class='Cnt'>{{GetData.Sum('PreAmount') + GetData.Sum('EnterAmount') + GetData.Sum('Tuition') + GetData.Sum('ScholarShip') + GetData.Sum('AddAmount') | digit}}</th>
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
	<script type="text/javascript" src="js/4084.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
	<script type="text/javascript" src="js/RefundStat.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
</body>
</html>