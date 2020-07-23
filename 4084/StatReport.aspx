<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StatReport.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_StatReport" %>
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
</head>
<body>
    <!--#include file="Header.html"-->
    <div id="Stat" style="text-align:left;margin-bottom:200px;">
        
        <div v-if="Loading" style="position:absolute;top:0px;left:0px;width:100%;height:2000px;text-align:center;
        filter:alpha(opacity=50);opacity:0.5;background-color:#CCCCCC;z-index:1;">
            <img src="/Admin/_Inc/CommonImg/SaveLoading.gif" alt="SaveLoading" style="margin-top:200px;" />
        </div>
        
        <div v-show="!Loading" style='display:none;'>
            <h2 style="text-align:center;">{{GetTitle}} 회계별 입금현황 (신입학)</h2>
            <h4 style="height:40px;">
                <div style='float:left;margin:3px;'>기준일자 : </div>
                <div style='float:left;'>
                    <vuejs-datepicker :format='customFormatter' v-model='NowDate' :typeable="true" ></vuejs-datepicker>
                </div>
            </h4>
            
            <h5>1. 금일 수입현황</h5>
            <table id="Content" class="table table-bordered table-condensed">
            <colgroup>
                <col width="5%" />
                <col width="5%" />
                <col width="*" />
                <col width="10%" />
                
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                
                <col width="15%" />
            </colgroup>
            <thead>
            <tr class="active">
                <th style='text-align:center;' rowspan='2' colspan='4'>회계별</th>
                <th style='text-align:center;' colspan='5'>수입내역(인원)</th>
                <th style='text-align:center;' rowspan='2'>금액</th>
            </tr>
            <tr class="active">
                <th style='text-align:center;'>수시1</th>
                <th style='text-align:center;'>수시2</th>
                <th style='text-align:center;'>정시</th>
                <th style='text-align:center;'>자율</th>
                <th style='text-align:center;'>계</th>
            </tr>
           </thead>
		    <tbody>
            <tr>
                <th class='vc' rowspan='6'>교비</th>
                <th class='vc' rowspan='3'>입학금</th>
                <th>수시예치금</th>
                <td class='Cnt'>300,000원</td>
                <td class='Cnt'>{{GetPreCntByAmt(1, '수시1') | digit}}</td>
                <td class='Cnt'>{{GetPreCntByAmt(1, '수시2') | digit}}</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>{{GetPreCntByAmt(1) | digit}}</td>
                <td class='Cnt'>{{GetPreAmountByAmt(1)}}</td>
            </tr>
            <tr>
                <th>수시입학금</th>
                <td class='Cnt'>271,000원</td>
                <td class='Cnt'>{{GetEnterCntByAmtS(1, '수시1') | digit}}</td>
                <td class='Cnt'>{{GetEnterCntByAmtS(1, '수시2') | digit}}</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>{{GetEnterCntByAmtS(1, '수시1', '수시2') | digit}}</td>
                <td class='Cnt'>{{GetEnterAmountByAmt(1, '수시1', '수시2')}}</td>
            </tr>
            <tr>
                <th>정시입학금</th>
                <td class='Cnt'>571,000원</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>&nbsp;</td>
                <td class='Cnt'>{{GetEnterCntByAmtJ(1, '정시') | digit}}</td>
                <td class='Cnt'>{{GetEnterCntByAmtJ(1, '자율') | digit}}</td>
                <td class='Cnt'>{{GetEnterCntByAmtJ(1, '정시', '자율') | digit}}</td>
                <td class='Cnt'>{{GetEnterAmountByAmt(1, '정시', '자율')}}</td>
            </tr>
            <tr>
                <th class='vc' rowspan='3'>수업료</th>
                <th>공학,공업,자연,예체</th>
                <td class='Cnt'>3,195,000원</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '1', '수시1') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '1', '수시2') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '1', '정시') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '1', '자율') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '1') | digit}}</td>
                <td class='Cnt'>{{GetTuitionAmount(1, '1')}}</td>
            </tr>
            <tr>
                <th>인문사회계</th>
                <td class='Cnt'>2,626,000원</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '2', '수시1') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '2', '수시2') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '2', '정시') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '2', '자율') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '2') | digit}}</td>
                <td class='Cnt'>{{GetTuitionAmount(1, '2')}}</td>
            </tr>
            <tr>
                <th>간호계</th>
                <td class='Cnt'>0원</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '3', '수시1') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '3', '수시2') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '3', '정시') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '3', '자율') | digit}}</td>
                <td class='Cnt'>{{GetTuitionCnt(1, '3') | digit}}</td>
                <td class='Cnt'>{{GetTuitionAmount(1, '3')}}</td>
            </tr>
            <tr>
                <th colspan='3'>학생자치경비</th>
                <td class='Cnt'>14,000원</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{GetTuitionAmount(1, '3')}}</td>
            </tr>
            </tbody>
            <tfoot>
            <tr class="active">
                <th colspan="2">합계</th>
                <th colspan="8" style='text-align:center;'>
                    예치금 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>{{GetPreAmountByAmt(1)}}</span>&nbsp; &nbsp; &nbsp; 
                    입학금 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>0 원</span>&nbsp; &nbsp; &nbsp; 
                    수업료 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>0 원</span>&nbsp; &nbsp; &nbsp; 
                </th>
            </tr>
            </tfoot>
            </table>

        </div>


        
        <div v-show="!Loading" style='display:none;'>
            <h5 style="float:left;">2. 금일 반환현황</h5>
            <table id="Content" class="table table-bordered table-condensed">
            <colgroup>
                <col width="5%" />
                <col width="5%" />
                <col width="*" />
                <col width="10%" />
                
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                
                <col width="15%" />
            </colgroup>
            <thead>
            <tr class="active">
                <th style='text-align:center;' rowspan='2' colspan='4'>회계별</th>
                <th style='text-align:center;' colspan='5'>반환내역(인원)</th>
                <th style='text-align:center;' rowspan='2'>금액</th>
            </tr>
            <tr class="active">
                <th style='text-align:center;'>수시1</th>
                <th style='text-align:center;'>수시2</th>
                <th style='text-align:center;'>정시</th>
                <th style='text-align:center;'>자율</th>
                <th style='text-align:center;'>계</th>
            </tr>
           </thead>
		    <tbody>
                <tr>
                    <th class='vc' rowspan='6'>교비</th>
                    <th class='vc' rowspan='3'>입학금</th>
                    <th>수시예치금</th>
                    <td class='Cnt'>300,000원</td>
                    <td class='Cnt'>{{GetPreCntByAmt(0, '수시1') | digit}}</td>
                    <td class='Cnt'>{{GetPreCntByAmt(0, '수시2') | digit}}</td>
                    <td class='Cnt'>&nbsp;</td>
                    <td class='Cnt'>&nbsp;</td>
                    <td class='Cnt'>{{GetPreCntByAmt(0) | digit}}</td>
                    <td class='Cnt'>{{GetPreAmountByAmt(0)}}</td>
                </tr>
                <tr>
                    <th>수시입학금</th>
                    <td class='Cnt'>271,000원</td>
                    <td class='Cnt'>{{GetEnterCntByAmtS(0, '수시1') | digit}}</td>
                    <td class='Cnt'>{{GetEnterCntByAmtS(0, '수시2') | digit}}</td>
                    <td class='Cnt'>&nbsp;</td>
                    <td class='Cnt'>&nbsp;</td>
                    <td class='Cnt'>{{GetEnterCntByAmtS(0, '수시1', '수시2') | digit}}</td>
                    <td class='Cnt'>{{GetEnterAmountByAmt(0, '수시1', '수시2')}}</td>
                </tr>
                <tr>
                    <th>정시입학금</th>
                    <td class='Cnt'>571,000원</td>
                    <td class='Cnt'>&nbsp;</td>
                    <td class='Cnt'>&nbsp;</td>
                    <td class='Cnt'>{{GetEnterCntByAmtJ(0, '정시') | digit}}</td>
                    <td class='Cnt'>{{GetEnterCntByAmtJ(0, '자율') | digit}}</td>
                    <td class='Cnt'>{{GetEnterCntByAmtJ(0, '정시', '자율') | digit}}</td>
                    <td class='Cnt'>{{GetEnterAmountByAmt(0, '정시', '자율')}}</td>
                </tr>
                <tr>
                    <th class='vc' rowspan='3'>수업료</th>
                    <th>공학,공업,자연,예체</th>
                    <td class='Cnt'>3,195,000원</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '1', '수시1') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '1', '수시2') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '1', '정시') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '1', '자율') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '1') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionAmount(0, '1')}}</td>
                </tr>
                <tr>
                    <th>인문사회계</th>
                    <td class='Cnt'>2,626,000원</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '2', '수시1') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '2', '수시2') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '2', '정시') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '2', '자율') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '2') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionAmount(0, '2')}}</td>
                </tr>
                <tr>
                    <th>간호계</th>
                    <td class='Cnt'>0원</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '3', '수시1') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '3', '수시2') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '3', '정시') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '3', '자율') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionCnt(0, '3') | digit}}</td>
                    <td class='Cnt'>{{GetTuitionAmount(0, '3')}}</td>
                </tr>
                <tr>
                    <th colspan='3'>학생자치경비</th>
                    <td class='Cnt'>14,000원</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetTuitionAmount(1, '3')}}</td>
                </tr>
            </tbody>
            <tfoot>
            <tr class="active">
                <th colspan="2">합계</th>
                <th colspan="8" style='text-align:center;'>
                    예치금 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>0 원</span>&nbsp; &nbsp; &nbsp; 
                    입학금 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>0 원</span>&nbsp; &nbsp; &nbsp; 
                    수업료 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>0 원</span>&nbsp; &nbsp; &nbsp; 
                </th>
            </tr>
            </tfoot>
            </table>

        </div>

        
        <div v-show="!Loading" style='display:none;'>
            <h5 style="float:left;">3. 집계표</h5>
            <table id="Content" class="table table-bordered table-condensed">
            <colgroup>
                <col width="*" />

                <col width="6%" />
                <col width="6%" />
                <col width="10%" />
                
                <col width="6%" />
                <col width="6%" />
                <col width="10%" />
                
                <col width="6%" />
                <col width="6%" />
                <col width="10%" />
                
                <col width="6%" />
                <col width="6%" />
                <col width="10%" />
            </colgroup>
            <thead>
            <tr class="active">
                <th style='text-align:center;' rowspan='3'>구분</th>
                <th style='text-align:center;' colspan='3'>전일누계</th>
                <th style='text-align:center;' colspan='3'>금일현황</th>
                <th style='text-align:center;' colspan='3'>금일반환</th>
                <th style='text-align:center;' colspan='3'>합계</th>
            </tr>
            <tr class="active">
                <th style='text-align:center;' colspan='2'>인원</th>
                <th style='text-align:center;' rowspan='2'>금액</th>
                <th style='text-align:center;' colspan='2'>인원</th>
                <th style='text-align:center;' rowspan='2'>금액</th>
                <th style='text-align:center;' colspan='2'>인원</th>
                <th style='text-align:center;' rowspan='2'>금액</th>
                <th style='text-align:center;' colspan='2'>인원</th>
                <th style='text-align:center;' rowspan='2'>금액</th>
            </tr>
            <tr class="active">
                <th style='text-align:center;'>일반</th>
                <th style='text-align:center;'>보훈</th>
                <th style='text-align:center;'>일반</th>
                <th style='text-align:center;'>보훈</th>
                <th style='text-align:center;'>일반</th>
                <th style='text-align:center;'>보훈</th>
                <th style='text-align:center;'>일반</th>
                <th style='text-align:center;'>보훈</th>
            </tr>
           </thead>
		    <tbody>
            <tr>
                <th>예치금</th>
                <td class='Cnt'>{{GetPreCntAcc() | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{GetPreAmountAcc()}}</td>
                <td class='Cnt'>{{GetPreCntByAmt(1) | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{GetPreAmountByAmt(1)}}</td>
                <td class='Cnt'>{{GetPreCntByAmt(0) | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{GetPreAmountByAmt(0)}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
            </tr>
            <tr>
                <th>입학</th>
                <td class='Cnt'>{{GetEnterCntAcc() | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{GetEnterAmountAcc()}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
            </tr>
            <tr>
                <th>수업료</th>
                <td class='Cnt'>{{GetTuitionCntAcc() | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{GetTuitionAmountAcc()}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>{{0 | digit}}</td>
                <td class='Cnt'>. 원</td>
            </tr>
            </tbody>
            <tfoot>
            <tr class="active">
                <th>합계</th>
                <th class='Cnt' colspan='3'>0 원</th>
                <th class='Cnt' colspan='3'>0 원</th>
                <th class='Cnt' colspan='3'>0 원</th>
                <th class='Cnt' colspan='3'>0 원</th>
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
	<script type="text/javascript" src="js/StatReport.js"></script>
</body>
</html>