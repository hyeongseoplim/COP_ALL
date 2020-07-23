<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundListAdd.aspx.cs" Inherits="Jinhak.SRSAdmin_4084._4084_RefundListAdd" %>
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
        

        <div v-show="!Loading" style='display:none;'>

            <h2 style="text-align:center;">{{GetTitle}} 입학포기자(환불) 지급조서 (전체)</h2>
            <h5 style="float:left;">                
                
                <button type="button" class="btn" v-bind:class="Type === '' ? 'btn-info' : ''" v-on:click="Type=''">전체</button>
                <button type="button" class="btn" v-bind:class="Type === '0' ? 'btn-info' : ''" v-on:click="Type='0'">예치금</button>
                <button type="button" class="btn" v-bind:class="Type === '1' ? 'btn-info' : ''" v-on:click="Type='1'">본등록</button>
                <button type="button" class="btn" v-bind:class="Type === '11' ? 'btn-info' : ''" v-on:click="Type='11'">전공심화</button>
                <button type="button" class="btn" v-bind:class="Type === '21' ? 'btn-info' : ''" v-on:click="Type='21'">산업체위탁</button>
                <button type="button" class="btn" v-bind:class="Type === '31' ? 'btn-info' : ''" v-on:click="Type='31'">편입학</button>

                <br/><br/>
                <div class="fl mid">환불기간 : </div>
                <vuejs-datepicker :format='customFormatter' v-model='GetStartDate' :typeable="true" wrapper-class="fl" input-class="tc"></vuejs-datepicker>
                <div class="fl mid"> ~ </div>
                <vuejs-datepicker :format='customFormatter' v-model='GetEndDate' :typeable="true" wrapper-class="fl" input-class="tc"></vuejs-datepicker>
                <br/><br/>
                <input type="radio" id="RefundComp" name="RefundStatus" Value="1" v-model="RefundStatus">
                <label for="RefundComp">환불완료</label>
                <input type="radio" id="RefundApproval" name="RefundStatus" Value="2" v-model="RefundStatus">
                <label for="RefundApproval">환불승인</label>

                    

            </h5>
            
            <table id="Content" class="table table-bordered table-condensed">
            <colgroup>
                <col width="3%" />
                
                <col width="*" />
                <col width="6%" />
                <col width="6%" />
                <col width="10%" />
                <col width="5%" />
                <col width="13%" />
                <col width="7%" />
                <col width="7%" />
                <col width="7%" />
                <col width="5%" />
            </colgroup>
            <thead>
            <tr class="active">
                <th class='tc'>순번</th>
                <th class='tc'>구분</th>                
                <th class='tc'>학과명</th>
                <th class='tc'>수험번호</th>
                <th class='tc'>성명</th>
                <th class='tc'>은행명</th>
                <th class='tc'>계좌번호</th>
                <th class='tc'>예금주</th>
                <th class='tc'>예치금</th>
                <th class='tc'>입학금</th>
                <th class='tc'>등록금</th>
                <th class='tc'>장학금</th> 
                <th class='tc'>학생회비</th>
                <th class='tc'>합계</th>
                <th class='tc'>비고</th>
            </tr>
           </thead>
		    <tbody>
            <tr v-for="(d,index) in GetDataByDate">
                <td>{{index+1}}</td>
                <td>{{d.RecruitTimeName}}</td>
                <td>{{MajorById[d.MajorId].MajorName}}</td>
                <td>{{d.ExamNo}}</td>
                <td>{{d.StuName}}</td>
                
                <td>{{d.BankName}}</td>
                <td>{{d.BankAccount}}</td>
                <td>{{d.BankAccountHolder}}</td>                

                <td class='Cnt'>{{GetAmount(d, 'PreAmount') | digit}}</td>
                <td class='Cnt'>{{GetAmount(d, 'EnterAmount') | digit}}</td>
                <td class='Cnt'>{{GetAmount(d, 'Tuition') | digit}}</td>
                <td class='Cnt'>{{GetAmount(d, 'ScholarShip') | digit}}</td>
                <td class='Cnt'>{{GetAmount(d, 'AddAmount') | digit}}</td>
                <td class='Cnt'>{{GetAmount(d) | digit}}</td>
                <td class='Cnt'>&nbsp;</td>
            </tr>
            <tr v-if="GetDataByDate.length == 0">
                <td colspan="15" style='text-align:center;padding:30px;'>
                    입학포기자 명단 데이터가 없습니다.
                </td>
            </tr>
            </tbody>
            <tfoot>
                    <tr class="active">
                        <th colspan="8">
                            합계 <span style="float:right;margin-right:50px;">{{GetDataByDate.length}} 명</span>
                        </th>
                        <th class='Cnt'>{{GetSumAmount('PreAmount') | digit}}</th>
                        <th class='Cnt'>{{GetSumAmount('EnterAmount') | digit}}</th>
                        <th class='Cnt'>{{GetSumAmount('Tuition') | digit}}</th>
                        <th class='Cnt'>{{GetSumAmount('ScholarShip') | digit}}</th>
                        <th class='Cnt'>{{GetSumAmount('PreAmount') + GetSumAmount('EnterAmount') + GetSumAmount('Tuition') + GetSumAmount('ScholarShip') | digit}}</th>
                        <th class='Cnt'>{{GetSumAmount('AddAmount') | digit}}</th>
                        <th class='Cnt'>{{GetSumAmount('PreAmount') + GetSumAmount('EnterAmount') + GetSumAmount('Tuition') + GetSumAmount('ScholarShip') + GetSumAmount('AddAmount') | digit}}</th>
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
	<script type="text/javascript" src="js/RefundListAdd.js?t=<%=DateTime.Now.Ticks.ToString()%>"></script>
</body>
</html>