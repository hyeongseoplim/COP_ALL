<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StatReportV4.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_StatReportV4" %>
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
    <div id="Stat" style="text-align:left;margin-bottom:200px;">
        
        <div v-if="Loading" style="position:absolute;top:0px;left:0px;width:100%;height:2000px;text-align:center;
        filter:alpha(opacity=50);opacity:0.5;background-color:#CCCCCC;z-index:1;">
            <img src="/Admin/_Inc/CommonImg/SaveLoading.gif" alt="SaveLoading" style="margin-top:200px;" />
        </div>
        

        <!-- #################################################################### -->

        <div v-show="!Loading" style='display:none;margin-bottom:10px;'>
            <h2 style="text-align:center;">{{GetTitle}} 회계별 입금현황 (산업체위탁)</h2>
            <h4 style="height:40px;">
                <div style='float:left;margin:3px;'>기준일자 : </div>
                <div style='float:left;'>
                    <vuejs-datepicker :format='customFormatter' v-model='NowDate' :typeable="true" ></vuejs-datepicker>
                </div>
            </h4>
            
            <div v-for='(tbl, tk, idx) in T' v-if="!tbl.hide">
                <h5>{{idx+1}}. 금일 {{tbl.text}}현황</h5>
                <table id="Content" class="table table-bordered table-condensed">
                <colgroup>
                    <col width="5%" />

                    <col width="10%" />
                    <col width="10%" />
                    <col width="12%" />
                    
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
                    <th style='text-align:center;' colspan='3'>{{tbl.text}}내역(인원)</th>
                </tr>
                <tr class="active">
                    <th v-for='col in C' v-if="!col.hide" style='text-align:center;'>{{col.text}}</th>
                </tr>
               </thead>
                <tbody>
                <tr>
                    <th rowspan='3'>교비</th>
                    <th>입학금</th>
                    <th>전학과</th>
                    <td class='Cnt'>466,000원</td>
                    <td v-for='col in C' v-if="!col.hide" class='Cnt'>
                        <span v-if="col.text != '금액'">{{GetResult(tbl, R.Row1, col) | digit}}</span>
                        <span v-if="col.text == '금액'">{{GetResultEtc(tbl, R.Row1, col) | digit}}</span>
                    </td>
                </tr>
                <tr v-for='row in R' v-if="!row.hide">
                    <th class='vc' v-if='row.cell1' :rowspan='row.cell1.rowspan || 1' :colspan='row.cell1.colspan || 1'>{{row.cell1.text}}</th>
                    <th class='vc' v-if='row.cell2' :rowspan='row.cell2.rowspan || 1' :colspan='row.cell2.colspan || 1'>{{row.cell2.text}}</th>
                    <th class='vc' v-if='row.cell3' :rowspan='row.cell3.rowspan || 1' :colspan='row.cell3.colspan || 1'>{{row.cell3.text}}</th>
                    <th v-html='row.text'></th>
                    <td class='Cnt'>{{row.amount}}</td>
                    <td v-for='col in C' v-if="!col.hide" class='Cnt'>
                        <span v-if="col.text != '금액'">{{GetResult(tbl, row, col) | digit}}</span>                        
                        <span v-if="col.text == '금액'">{{GetResultEtc(tbl, row, col) | digit}}</span>
                    </td>
                </tr>
                <tr>
                    <th colspan="3">학생자치경비</th>
                    <td class='Cnt'>14,000원</td>
                    <td v-for='col in C' v-if="!col.hide" class='Cnt'>{{GetResult(tbl, R.RowAdd, col)  | digit}}</td>
                </tr>               
                </tbody>
                <tfoot>
                <tr class="active">
                    <th colspan="2">합계</th>
                    <th colspan="8" style='text-align:center;'>
                        예치금 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>{{GetResult(tbl, R.RowPre, C.ColSum)  | digit}}</span>&nbsp; &nbsp; &nbsp; 
                        입학금 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>{{GetResult(tbl, R.RowEnter, C.ColSum) + GetResult(tbl, R.RowEnterScholarShip, C.ColSum)    | digit}}</span>&nbsp; &nbsp; 
                        수업료 : <span style='display:inline-block;width:23%;text-align:right;padding-right:5px;'>{{GetResult(tbl, R.RowTuition, C.ColSum) + GetResult(tbl, R.RowTuitionScholarShip, C.ColSum)  | digit}}</span>&nbsp; &nbsp; 
                    </th>
                </tr>
                </tfoot>
                </table>
            </div>

        </div>

        <!-- #################################################################### -->


        <div v-show="!Loading" style='display:none;'>
            <h5 style="float:left;">3. 집계표</h5>
            <table id="Content" class="table table-bordered table-condensed">
            <colgroup>
                <col width="*" />

                <col width="5%" />
                <col width="5%" />
                <col width="12%" />
                
                <col width="5%" />
                <col width="5%" />
                <col width="12%" />
                
                <col width="5%" />
                <col width="5%" />
                <col width="12%" />
                
                <col width="5%" />
                <col width="5%" />
                <col width="12%" />
                
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
                    <th>입학</th>                
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowEnter, C.ColTotal) - GetResult(T.TBL4, R.RowEnter, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowEnter, C.ColSum) - GetResult(T.TBL4, R.RowEnter, C.ColSum) + GetResult(T.TBL3, R.RowEnterScholarShip, C.ColSum) + GetResult(T.TBL4, R.RowEnterScholarShip, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{GetResult(T.TBL1, R.RowEnter, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL1, R.RowEnter, C.ColSum) + GetResult(T.TBL1, R.RowEnterScholarShip, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{GetResult(T.TBL2, R.RowEnter, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL2, R.RowEnter, C.ColSum) + GetResult(T.TBL2, R.RowEnterScholarShip, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{((GetResult(T.TBL3, R.RowEnter, C.ColTotal) - GetResult(T.TBL4, R.RowEnter, C.ColTotal)) + GetResult(T.TBL1, R.RowEnter, C.ColTotal) - GetResult(T.TBL2, R.RowEnter, C.ColTotal)) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{
                        GetResult(T.TBL3, R.RowEnter, C.ColSum) - GetResult(T.TBL4, R.RowEnter, C.ColSum) + 
                        GetResult(T.TBL1, R.RowEnter, C.ColSum) - GetResult(T.TBL2, R.RowEnter, C.ColSum) +
                        GetResult(T.TBL3, R.RowEnterScholarShip, C.ColSum) - GetResult(T.TBL4, R.RowEnterScholarShip, C.ColSum) +
                        GetResult(T.TBL1, R.RowEnterScholarShip, C.ColSum) - GetResult(T.TBL2, R.RowEnterScholarShip, C.ColSum)  | digit}}
                    </td>
                </tr>
                <tr>
                    <th>수업료</th>
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowTuition, C.ColTotal) - GetResult(T.TBL4, R.RowTuition, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowTuition, C.ColSum) - GetResult(T.TBL4, R.RowTuition, C.ColSum) + GetResult(T.TBL3, R.RowTuitionScholarShip, C.ColSum) + GetResult(T.TBL4, R.RowTuitionScholarShip, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{GetResult(T.TBL1, R.RowTuition, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL1, R.RowTuition, C.ColSum) + GetResult(T.TBL1, R.RowTuitionScholarShip, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{GetResult(T.TBL2, R.RowTuition, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL2, R.RowTuition, C.ColSum) + GetResult(T.TBL2, R.RowTuitionScholarShip, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{((GetResult(T.TBL3, R.RowTuition, C.ColTotal) - GetResult(T.TBL4, R.RowTuition, C.ColTotal)) + GetResult(T.TBL1, R.RowTuition, C.ColTotal) - GetResult(T.TBL2, R.RowTuition, C.ColTotal)) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{
                        GetResult(T.TBL3, R.RowTuition, C.ColSum) - GetResult(T.TBL4, R.RowTuition, C.ColSum) + 
                        GetResult(T.TBL1, R.RowTuition, C.ColSum) - GetResult(T.TBL2, R.RowTuition, C.ColSum) +
                        GetResult(T.TBL3, R.RowTuitionScholarShip, C.ColSum) - GetResult(T.TBL4, R.RowTuitionScholarShip, C.ColSum) + 
                        GetResult(T.TBL1, R.RowTuitionScholarShip, C.ColSum) - GetResult(T.TBL2, R.RowTuitionScholarShip, C.ColSum) | digit}}
                    </td>
                </tr>
                <tr>
                    <th>학생경비</th>
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowAdd, C.ColTotal) - GetResult(T.TBL4, R.RowAdd, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowAdd, C.ColSum) - GetResult(T.TBL4, R.RowAdd, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{GetResult(T.TBL1, R.RowAdd, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL1, R.RowAdd, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{GetResult(T.TBL2, R.RowAdd, C.ColTotal) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL2, R.RowAdd, C.ColSum) | digit}}</td>
    
                    <td class='Cnt'>{{((GetResult(T.TBL3, R.RowAdd, C.ColTotal) - GetResult(T.TBL4, R.RowAdd, C.ColTotal)) + GetResult(T.TBL1, R.RowAdd, C.ColTotal) - GetResult(T.TBL2, R.RowAdd, C.ColTotal)) | digit}}</td>
                    <td class='Cnt'>{{0 | digit}}</td>
                    <td class='Cnt'>{{GetResult(T.TBL3, R.RowAdd, C.ColSum) - GetResult(T.TBL4, R.RowAdd, C.ColSum) + GetResult(T.TBL1, R.RowAdd, C.ColSum) - GetResult(T.TBL2, R.RowAdd, C.ColSum) | digit}}</td>
                </tr>
                </tbody>
                <tfoot>
                <tr class="active">
                    <th>합계</th>
                    <th class='Cnt' colspan='3'>
                        {{
                            (GetResult(T.TBL3, R.RowPre, C.ColSum)  - GetResult(T.TBL4, R.RowPre, C.ColSum)) +                        
                            (GetResult(T.TBL3, R.RowEnter, C.ColSum)  - GetResult(T.TBL4, R.RowEnter, C.ColSum)) +
                            (GetResult(T.TBL3, R.RowTuition, C.ColSum)  - GetResult(T.TBL4, R.RowTuition, C.ColSum)) +                        
                            (GetResult(T.TBL3, R.RowEnterScholarShip, C.ColSum) + GetResult(T.TBL4, R.RowEnterScholarShip, C.ColSum)) +
                            (GetResult(T.TBL3, R.RowTuitionScholarShip, C.ColSum)  + GetResult(T.TBL4, R.RowTuitionScholarShip, C.ColSum))
                            | digit
                        }}
                    </th>
                    <th class='Cnt' colspan='3'>
                        {{
                            GetResult(T.TBL1, R.RowPre, C.ColSum) +
                            GetResult(T.TBL1, R.RowEnter, C.ColSum) +
                            GetResult(T.TBL1, R.RowTuition, C.ColSum) +                        
                            GetResult(T.TBL1, R.RowEnterScholarShip, C.ColSum) +
                            GetResult(T.TBL1, R.RowTuitionScholarShip, C.ColSum)
                            | digit
                        }}
                    </th>
                    <th class='Cnt' colspan='3'>
                        {{
                            GetResult(T.TBL2, R.RowPre, C.ColSum) +
                            GetResult(T.TBL2, R.RowEnter, C.ColSum) + 
                            GetResult(T.TBL2, R.RowTuition, C.ColSum)  +
                            GetResult(T.TBL2, R.RowEnterScholarShip, C.ColSum) +
                            GetResult(T.TBL2, R.RowTuitionScholarShip, C.ColSum) 
                            | digit
                        }}
                    </th>
                    <th class='Cnt' colspan='3'>
                        {{
                            (GetResult(T.TBL3, R.RowPre, C.ColSum) - GetResult(T.TBL4, R.RowPre, C.ColSum) 
                            + GetResult(T.TBL1, R.RowPre, C.ColSum) - GetResult(T.TBL2, R.RowPre, C.ColSum))
                            + (GetResult(T.TBL3, R.RowEnter, C.ColSum) - GetResult(T.TBL4, R.RowEnter, C.ColSum) 
                            + GetResult(T.TBL1, R.RowEnter, C.ColSum) - GetResult(T.TBL2, R.RowEnter, C.ColSum))
                            + (GetResult(T.TBL3, R.RowTuition, C.ColSum) - GetResult(T.TBL4, R.RowTuition, C.ColSum) 
                            + GetResult(T.TBL1, R.RowTuition, C.ColSum) - GetResult(T.TBL2, R.RowTuition, C.ColSum))
                            + (GetResult(T.TBL3, R.RowAdd, C.ColSum) - GetResult(T.TBL4, R.RowAdd, C.ColSum) 
                            + GetResult(T.TBL1, R.RowAdd, C.ColSum) - GetResult(T.TBL2, R.RowAdd, C.ColSum))
    
                            + (GetResult(T.TBL3, R.RowEnterScholarShip, C.ColSum) + GetResult(T.TBL4, R.RowEnterScholarShip, C.ColSum) 
                            + GetResult(T.TBL1, R.RowEnterScholarShip, C.ColSum) + GetResult(T.TBL2, R.RowEnterScholarShip, C.ColSum))
                            + (GetResult(T.TBL3, R.RowTuitionScholarShip, C.ColSum) + GetResult(T.TBL4, R.RowTuitionScholarShip, C.ColSum) 
                            + GetResult(T.TBL1, R.RowTuitionScholarShip, C.ColSum) + GetResult(T.TBL2, R.RowTuitionScholarShip, C.ColSum))
                            | digit}}
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
	<script type="text/javascript" src="js/StatReportV4.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
</body>
</html>