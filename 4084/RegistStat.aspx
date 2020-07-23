<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistStat.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RegistStat" %>
<!DOCTYPE html>
<html>
<head>
    <title>서일대</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/4084.css" rel="stylesheet" />
    <script>var PageType = "<%=Type%>";</script>
</head>
<body>
<!--#include file="Header.html"-->
<div id="Stat" style="text-align:left;margin-bottom:200px;">
<div v-if="Loading" style="position:absolute;top:0px;left:0px;width:100%;height:2000px;text-align:center;
filter:alpha(opacity=50);opacity:0.5;background-color:#CCCCCC;z-index:1;">
    <img src="/Admin/_Inc/CommonImg/SaveLoading.gif" alt="SaveLoading" style="margin-top:200px;" />
</div>


    <!-- 4. 등록 총괄 -->
    <div v-if="PageType == '4'" v-show="!Loading" style='display:none;'>
        <h2 style="text-align:center;">{{GetTitle}} 등록 총괄 (신입학)</h2>

        <h5 style="float:left;">전체</h5>
        <h5 style="float:right;">등록일자 : {{DisplayNowDate()}}</h5>
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
            <th rowspan='2' style='text-align:center;'>학과</th>
            <th rowspan='2' style='text-align:center;'>주야</th>
            <th rowspan='2' style='text-align:center;'>정원</th>
            <th rowspan='2' style='text-align:center;'>전일누계</th>
            <th colspan='2' style='text-align:center;'>금일반환</th>
            <th rowspan='2' style='text-align:center;'>계</th>
            <th rowspan='2' style='text-align:center;'>결원</th>
            <th rowspan='2' style='text-align:center;'>비고</th>
        </tr>
        <tr class="active">
            <th style='text-align:center;'>예치</th>
            <th style='text-align:center;'>완납</th>
        </tr>
        </thead>
        <tbody v-for="jy in JY">
        <tr v-for="major in GetMajor(jy)">
            <td>[{{major.MajorCode}}]{{major.MajorName}}</td>
            <td style='text-align:center;'>{{major.Type}}</td>
            <td class='Cnt'>{{MajorPersonnelByCode[major.MajorCode]}}</td>
            <td class='Cnt'>{{GetPrevAccum(major).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowRefund(major, R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowRefund(major, R.Row1).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetPrevAccum(major).Count('ExamNo') - GetNowRefund(major, R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr class="active">
            <th colspan='2' style='text-align:center;'>{{jy}} 소계</th>
            <th class='Cnt'>{{GetMajorPersonnelByJY(jy) | digit}}</th>
            <th class='Cnt'>{{GetPrevAccum(GetMajor(jy)).Count('ExamNo') | digit}}</th>
            <td class='Cnt'>{{GetNowRefund(GetMajor(jy), R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowRefund(GetMajor(jy), R.Row1).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetPrevAccum(GetMajor(jy)).Count('ExamNo') - GetNowRefund(GetMajor(jy), R.Row2).Count('ExamNo') | digit}}</td>
            <th class='Cnt'>&nbsp;</th>
            <th>&nbsp;</th>
        </tr>
        </tbody>
        <tfoot>
        <tr class="active">
            <td colspan='2' style='text-align:center;'>합계</td>
            <th class='Cnt'>{{MajorPersonnel.Sum('Personnel') | digit}}</th>
            <th class='Cnt'>{{GetPrevAccum().Count('ExamNo') | digit}}</th>
            <td class='Cnt'>{{GetNowRefund(undefined, R.Row2).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetNowRefund(undefined, R.Row1).Count('ExamNo') | digit}}</td>
            <td class='Cnt'>{{GetPrevAccum().Count('ExamNo') - GetNowRefund(undefined, R.Row2).Count('ExamNo') | digit}}</td>
            <th class='Cnt'>&nbsp;</th>
            <th>&nbsp;</th>
        </tr>
        </tfoot>
        </table>

    </div>

    <!-- 5. 등록 현황 -->
    <div v-if="PageType == '5'" v-show="!Loading" style='display:none;'>
        <h2 style="text-align:center;">{{GetTitle}} 등록현황 (신입학)</h2>
    </div>

    <!-- 6. 등록금액 정보내역 -->
    <div v-if="PageType == '6'" v-show="!Loading" style='display:none;'>
        <h2 style="text-align:center;">{{GetTitle}} 등록금액 정보내역 (신입학)</h2>
    </div>

    <!-- 7. 등록자 명단 -->
    <div v-if="PageType == '7'" v-for="(major, majorid, idx) in MajorById" v-show="GetDataByMajorId(major).length > 0" style='display:none;'>

        <h2 style="text-align:center;">{{GetTitle}} 등록자 명단 (전체)</h2>

        
        <button type="button" class="btn" v-bind:class="Type === '' ? 'btn-info' : ''" v-on:click="Type=''">전체</button>
        <button type="button" class="btn" v-bind:class="Type === '0' ? 'btn-info' : ''" v-on:click="Type='0'">예치금</button>
        <button type="button" class="btn" v-bind:class="Type === '1' ? 'btn-info' : ''" v-on:click="Type='1'">본등록</button>
        <button type="button" class="btn" v-bind:class="Type === '11' ? 'btn-info' : ''" v-on:click="Type='11'">전공심화</button>
        <button type="button" class="btn" v-bind:class="Type === '21' ? 'btn-info' : ''" v-on:click="Type='21'">산업체위탁</button>
        <button type="button" class="btn" v-bind:class="Type === '31' ? 'btn-info' : ''" v-on:click="Type='31'">편입학</button>
        <br/><br/>
           
        <h5 style="float:left;">{{major.MajorName}}</h5>
        <h5 style="float:right;">{{DisplayNowDate()}} 현재 등록기준</h5>
        <table id="Content" class="table table-bordered table-condensed">
        <thead>
        <tr class="active">
            <th>순번</th>
            <th>수험번호</th>
            <th>성명</th>
            <th>생년월일</th>
            <th>성별</th>
            <th>등록구분</th>
            <th>휴대폰</th>
            <th>보호자휴대폰</th>
            <th>일반전화</th>
            <th>입학구분</th>
            <th>비고</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="d in GetDataByMajorId(major)">
            <td>{{d.RowNumber}}</td>
            <td>{{d.ExamNo}}</td>
            <td>{{d.StuName}}</td>
            <td>{{DisplayBirthday(d.DecStuSSN)}}</td>
            <td>{{DisplayGender(d.DecStuSSN)}}</td>
            <td>등록</td>
            <td>{{d.Mobile}}</td>
            <td>{{d.ParentPhone}}</td>
            <td>{{d.Phone}}</td>
            <td>신입</td>
            <td>&nbsp;</td>
        </tr>
        <tr v-if="GetDataByMajorId(major).length == 0">
            <td colspan="11" style='text-align:center;padding:30px;'>
                등록자 명단 데이터가 없습니다.
            </td>
        </tr>
        </tbody>
        <tfoot>
        <tr class="active">
            <th colspan="11">
                합계
                <span style="float:right;margin-right:50px;">{{GetDataByMajorId(major).length}} 명</span>
            </th>
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
<script type="text/javascript" src="js/RegistStat.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
</body>
</html>