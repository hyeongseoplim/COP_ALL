<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistStatA.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RegistStatA" %>
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
    <!-- 6. 등록금액 정보내역 -->
    <div v-show="!Loading" style='display:none;'>
        <h2 style="text-align:center;">{{GetTitle}} 등록금액 정보내역 (신입학)</h2>
        

        <button type="button" class="btn" v-bind:class="Type === '' ? 'btn-info' : ''" v-on:click="Type=''">전체</button>
        <button type="button" class="btn" v-bind:class="Type === '0' ? 'btn-info' : ''" v-on:click="Type='0'">예치금</button>
        <button type="button" class="btn" v-bind:class="Type === '1' ? 'btn-info' : ''" v-on:click="Type='1'">본등록</button>
        <button type="button" class="btn" v-bind:class="Type === '11' ? 'btn-info' : ''" v-on:click="Type='11'">전공심화</button>
        <button type="button" class="btn" v-bind:class="Type === '21' ? 'btn-info' : ''" v-on:click="Type='21'">산업체위탁</button>
        <button type="button" class="btn" v-bind:class="Type === '31' ? 'btn-info' : ''" v-on:click="Type='31'">편입학</button>
        <br/><br/>
        
        <h5 style="float:left;">
            <div class="fl mid">등록기간 : </div>
            <vuejs-datepicker :format='customFormatter' v-model='GetStartDate' :typeable="true" wrapper-class="fl" input-class="tc"></vuejs-datepicker>
            <div class="fl mid"> ~ </div>
            <vuejs-datepicker :format='customFormatter' v-model='GetEndDate' :typeable="true" wrapper-class="fl" input-class="tc"></vuejs-datepicker>
        </h5>
        <table id="Content" class="table table-bordered table-condensed">
        <thead>
        <tr class="active">
            <th class='tc vc' rowspan="2">순번</th>
            <th class='tc vc' rowspan="2">수험번호</th>
            <th class='tc vc' rowspan="2">성명</th>
            <th class='tc vc' colspan="4">등록금</th>
            <th class='tc vc' colspan="4">납부금액</th>
            <th class='tc vc' rowspan="2">비고</th>
            <th class='tc vc' rowspan="2">학생회비</th>
        </tr>
        <tr class="active">
            <th class='tc vc'>예치금</th>
            <th class='tc vc'>입학금</th>
            <th class='tc vc'>수업료</th>
            <th class='tc vc'>계</th>
            <th class='tc vc'>예치금</th>
            <th class='tc vc'>입학금</th>
            <th class='tc vc'>수업료</th>
            <th class='tc vc'>계</th>
        </tr>
        </thead>
        <tbody>
        <tr v-for="(d,index) in GetAmountData">
            <td>{{index+1}}</td>
            <td>{{d.ExamNo}}</td>
            <td>{{d.StuName}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].PreAmount | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].EnterAmount | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].Tuition | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].PreAmount + AmtID[d.SRSID].EnterAmount  + AmtID[d.SRSID].Tuition | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].PrePaid | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].EnterPaid - AmtID[d.SRSID].EnterScholarShip | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].TuitionPaid - AmtID[d.SRSID].TuitionScholarShip | digit}}</td>
            <td class='Cnt'>{{AmtID[d.SRSID].PrePaid + AmtID[d.SRSID].EnterPaid  + AmtID[d.SRSID].TuitionPaid - AmtID[d.SRSID].ScholarShip | digit}}</td>
            <td class='Cnt'>&nbsp;</td>
            <td class='Cnt'>{{AmtID[d.SRSID].AddPaid | digit}}</td></td>
        </tr>
        <tr v-if="GetAmountData.length == 0">
            <td colspan="11" style='text-align:center;padding:30px;'>
                등록자 명단 데이터가 없습니다.
            </td>
        </tr>
        <tr class="active">
            <th colspan="2">소계</th>
            <th class='Cnt'>{{GetAmountData.length | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PreAmount') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('EnterAmount') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('Tuition') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PreAmount') + SumAmt.Sum('EnterAmount')  + SumAmt.Sum('Tuition') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PrePaid') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('EnterPaid') - SumAmt.Sum('EnterScholarShip') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('TuitionPaid') - SumAmt.Sum('TuitionScholarShip') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PrePaid') + SumAmt.Sum('EnterPaid')  + SumAmt.Sum('TuitionPaid') - SumAmt.Sum('ScholarShip') | digit}}</th>
            <th class='Cnt'>&nbsp;</th>
            <th class='Cnt'>{{SumAmt.Sum('AddPaid') | digit}}</th>
        </tr>
        <tr class="active">
            <th colspan="2">합계</th>
            <th class='Cnt'>{{GetAmountData.length | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PreAmount') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('EnterAmount') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('Tuition') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PreAmount') + SumAmt.Sum('EnterAmount')  + SumAmt.Sum('Tuition') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PrePaid') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('EnterPaid') - SumAmt.Sum('EnterScholarShip') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('TuitionPaid') - SumAmt.Sum('TuitionScholarShip') | digit}}</th>
            <th class='Cnt'>{{SumAmt.Sum('PrePaid') + SumAmt.Sum('EnterPaid')  + SumAmt.Sum('TuitionPaid') - SumAmt.Sum('ScholarShip') | digit}}</th>
            <th class='Cnt'>&nbsp;</th>
            <th class='Cnt'>{{SumAmt.Sum('AddPaid') | digit}}</th>
        </tr>
        </tbody>
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
<script type="text/javascript" src="js/RegistStatA.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
</body>
</html>