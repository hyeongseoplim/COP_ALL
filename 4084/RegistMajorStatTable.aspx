<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistMajorStatTable.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RegistMajorStatTable" %>
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
        

        <div v-show="!Loading" style='display:none;' v-for='(RName, UnivServiceId) in GetRecruitTime'>

            <h2 style="text-align:center;">{{GetTitle}} 등록자 납부 현황표 ({{RName}})</h2>
            <table id="Content" class="table table-bordered table-condensed">
            <thead>
            <tr class="active">
                <th rowspan='2'>학과명</th>
                <template v-for="(s, sg) in GetSelection">
                <template v-for="(code, sname) in s">
                <th colspan='3' style='text-align:center;'>{{sname}}</th>
                </template>
                <th colspan='4' style='text-align:center;'>{{sg}}</th>
                </template>
                <th colspan='4' style='text-align:center;'>합계</th>
            </tr>
            <tr class="active">
                <template v-for="(s, sg) in GetSelection">
                <template v-for="(code, sname) in s">
                <th style='text-align:center;'>모집<br />인원</th>
                <th style='text-align:center;'>등록<br />인원</th>
                <th style='text-align:center;'>미등<br />록자</th>
                </template>
                <th style='text-align:center;'>모집<br />인원</th>
                <th style='text-align:center;'>등록<br />인원</th>
                <th style='text-align:center;'>미등<br />록자</th>
                <th style='text-align:center;'>등록<br />비율</th>
                </template>
                <th style='text-align:center;'>모집<br />인원</th>
                <th style='text-align:center;'>등록<br />인원</th>
                <th style='text-align:center;'>미등<br />록자</th>
                <th style='text-align:center;'>등록<br />비율</th>
            </tr>
            </thead>
		    <tbody v-for="(majorList, majortype) in GetMajor(UnivServiceId)">
            <tr v-for="major in majorList">
                <td>{{major.MajorName}}</td>
                <template v-for="(s, sg) in GetSelection">
                <template v-for="(scode, sname) in s">
                <td class="Cnt warning">{{GetPersonnel(UnivServiceId, major.MajorCode, scode) | digit}}</td>
                <td class="Cnt">{{GetPayCnt(UnivServiceId, major.MajorCode, scode) | digit}}</td>
                <td class="Cnt">{{GetUnPayCnt(UnivServiceId, major.MajorCode, scode) | digit}}</td>
                </template>
                <td class="Cnt warning">{{GetPersonnel(UnivServiceId, major.MajorCode, s) | digit}}</td>
                <td class="Cnt">{{GetPayCnt(UnivServiceId, major.MajorCode, s) | digit}}</td>
                <td class="Cnt">{{GetUnPayCnt(UnivServiceId, major.MajorCode, s) | digit}}</td>
                <td class="Cnt">{{GetRatio(UnivServiceId, major.MajorCode, s)}}</td>
                </template>
                <td class="Cnt warning">{{GetPersonnel(UnivServiceId, major.MajorCode) | digit}}</td>
                <td class="Cnt">{{GetPayCnt(UnivServiceId, major.MajorCode) | digit}}</td>
                <td class="Cnt">{{GetUnPayCnt(UnivServiceId, major.MajorCode) | digit}}</td>
                <td class="Cnt">{{GetRatio(UnivServiceId, major.MajorCode)}}</td>
            </tr>
            <tr class="success">
                <th>소계</th>
                <template v-for="(s, sg) in GetSelection">
                <template v-for="(scode, sname) in s">
                <th class="Cnt">{{GetPersonnel(UnivServiceId, majorList, scode) | digit}}</th>
                <th class="Cnt">{{GetPayCnt(UnivServiceId, majorList, scode) | digit}}</th>
                <th class="Cnt">{{GetUnPayCnt(UnivServiceId, majorList, scode) | digit}}</th>
                </template>
                <th class="Cnt">{{GetPersonnel(UnivServiceId, majorList, s) | digit}}</th>
                <th class="Cnt">{{GetPayCnt(UnivServiceId, majorList, s) | digit}}</th>
                <th class="Cnt">{{GetUnPayCnt(UnivServiceId, majorList, s) | digit}}</th>
                <th class="Cnt">{{GetRatio(UnivServiceId, majorList, s)}}</th>
                </template>
                <th class="Cnt">{{GetPersonnel(UnivServiceId, majorList) | digit}}</th>
                <th class="Cnt">{{GetPayCnt(UnivServiceId, majorList) | digit}}</th>
                <th class="Cnt">{{GetUnPayCnt(UnivServiceId, majorList) | digit}}</th>
                <th class="Cnt">{{GetRatio(UnivServiceId, majorList)}}</th>
            </tr>
            </tbody>
            <tfoot>
            <tr class="info">
                <th>합계</th>
                <template v-for="(s, sg) in GetSelection">
                <template v-for="(scode, sname) in s">
                <th class="Cnt">{{GetPersonnel(UnivServiceId, undefined, scode) | digit}}</th>
                <th class="Cnt">{{GetPayCnt(UnivServiceId, undefined, scode) | digit}}</th>
                <th class="Cnt">{{GetUnPayCnt(UnivServiceId, undefined, scode) | digit}}</th>
                </template>
                <th class="Cnt">{{GetPersonnel(UnivServiceId, undefined, s) | digit}}</th>
                <th class="Cnt">{{GetPayCnt(UnivServiceId, undefined, s) | digit}}</th>
                <th class="Cnt">{{GetUnPayCnt(UnivServiceId, undefined, s) | digit}}</th>
                <th class="Cnt">{{GetRatio(UnivServiceId, undefined, s)}}</th>
                </template>
                <th class="Cnt">{{GetPersonnel(UnivServiceId) | digit}}</th>
                <th class="Cnt">{{GetPayCnt(UnivServiceId) | digit}}</th>
                <th class="Cnt">{{GetUnPayCnt(UnivServiceId) | digit}}</th>
                <th class="Cnt">{{GetRatio(UnivServiceId)}}</th>
            </tr>
            </tfoot>
            </table>

        </div>



    </div>
    
    <script type="text/javascript" src="/Admin/_inc/js/jquery.min.js"></script>
    <script type="text/javascript" src="/Admin/_inc/js/Common.js"></script>
	<script type="text/javascript" src="js/lodash.js"></script>
	<script type="text/javascript" src="js/vue.js"></script>
	<script type="text/javascript" src="js/4084.js"></script>
	<script type="text/javascript" src="js/RegistMajorStatTable.js"></script>
</body>
</html>