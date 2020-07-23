<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistMajorStat.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RegistMajorStat" %>
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
        
        
            <h2 style="text-align:center;">2020학년도 1학기 합격생 등록 총계 (전체)</h2>    
            <button type="button" class="btn" v-bind:class="Type === '' ? 'btn-info' : ''" v-on:click="Type=''">전체</button>
            <button type="button" class="btn" v-bind:class="Type === '0' ? 'btn-info' : ''" v-on:click="Type='0'">예치금</button>
            <button type="button" class="btn" v-bind:class="Type === '1' ? 'btn-info' : ''" v-on:click="Type='1'">본등록</button>
            <button type="button" class="btn" v-bind:class="Type === '11' ? 'btn-info' : ''" v-on:click="Type='11'">전공심화</button>
            <button type="button" class="btn" v-bind:class="Type === '21' ? 'btn-info' : ''" v-on:click="Type='21'">산업체위탁</button>
            <br/><br/>

            <table id="Content" class="table table-bordered table-condensed">
            <thead>
            <tr class="active">
                <th>순번</th>
                <th>모집시기</th>
                <th>학과명</th>
                <th>고지입학금</th>
                <th>고지수업료</th>
                <th>고지금액</th>
                <th>장학금</th>
                <th>납부예치금</th>
                <th>납부입학금</th>
                <th>납부수업료</th>
                <th>합계</th>
                <th>일반</th>
                <th>보훈</th>
            </tr>
           </thead>
		    <tbody>
            <tr v-for="(d,index) in GetDataByMajorId()">
                <td>{{index+1}}</td>
                <td>{{d.RecruitTimeName}}</td>
                <td>{{d.MajorName}}</td>
                <td>{{d.NotiEnterAmount}}</td>
                <td>{{d.NotiTuition}}</td>
                <td>{{d.NotiTuition + d.NotiEnterAmount}}</td>
                <td>{{d.NotiScholarShip}}</td>
                <td>{{d.PreAmount}}</td>
                <td>{{d.EnterAmount - d.EnterScholarShip}}</td>
                <td>{{d.Tuition - d.TuitionScholarShip}}</td>
                <!--<td>{{d.PreAmount + d.EnterAmount + d.Tuition }}</td>-->
                <td>{{d.PayAmount}}</td>
                <td>{{d.RegistStuCnt}}</td>
                <td>&nbsp;</td>
            </tr>
            </tbody>
            </table>


    </div>
    
    <script type="text/javascript" src="/Admin/_inc/js/jquery.min.js"></script>
    <script type="text/javascript" src="/Admin/_inc/js/Common.js"></script>
	<script type="text/javascript" src="js/lodash.js"></script>
	<script type="text/javascript" src="js/vue.js"></script>
    <script type="text/javascript" src="js/vuejs-datepicker.min.js"></script>
    <script type="text/javascript" src="js/RegistMajorStat.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
	<script type="text/javascript" src="js/4084.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
</body>
</html>