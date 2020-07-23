var appStatistics = null;



(function(){
    appStatistics = new Vue({
        el: '#Stat',        
        mixins : [Vue4084],
        data: {
            Data: [],
            C : {
              Col1 : {
                text : '최초',
                c : function(d){return d.UnivServiceId.IN(408406)},
                result : function(data){
                  return data.Count('ExamNo');
                }
              },
              Col2 : {
                text : '추가',
                c : function(d){return d.UnivServiceId.IN(408407)},
                result : function(data){
                  return data.Count('ExamNo');
                }
              },
              Col3 : {
                hide : true
              },
              Col4 : {
                hide : true
              },
              ColTotal : {
                hide : true
              },
              ColSum : {
                hide : false,
                text : '금액',
                c : function(d){return true},
                result : function(data, row){
                  return data.Sum(row.GetKey());
                  //return (sum == 0) ? '0원' : sum.format() + "원";
                },
                resultEtc : function(data, row){
                  console.log(data, data.Sum(row.GetKey() + "ScholarShip"));
                  return data.Sum(row.GetKey()) + data.Sum(row.GetKey() + "ScholarShip");
                  //return (sum == 0) ? '0원' : sum.format() + "원";
                }
              },
            },
            R : {
                Row1 : {
                  hide : true,
                  text : '입학금',
                  c : function(d){
                    // 수시1차,2차 본등록 + 정시1차,2차 본등록
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "EnterAmount"}
                },
                Row2 : {
                  cell2 : {text : '수업료', rowspan : 4},        
                  cell3 : {text : '공학, 자연과학, 예체능', rowspan : 2},
                  text : '1년제',
                  amount : '2,953,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407) && d.CollegeCode != '3' && d.Tuition == "2953000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row3 : {
                  hide:false,
                  text : '2년제',
                  amount : '3,195,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407) && d.CollegeCode != '3' && d.Tuition == "3195000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row4 : {
                  hide:false,
                  cell3 : {text : '인문사회', rowspan:2},
                  text : '1년제',
                  amount : '2,427,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407) && d.CollegeCode == '3' && d.Tuition == "2427000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row5 : {                                    
                  text : '2년제',
                  amount : '2,626,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407) && d.CollegeCode == '3' && d.Tuition == "2626000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row6 : {
                  hide : true,
                  cell3 : {text : '인문사회계', rowspan:2},
                  text : '1년제',
                  amount : '2,427,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407) && d.CollegeCode == '2'
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row7 : {
                  hide : true,
                  text : '2년제',
                  amount : '2,626,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407) && d.CollegeCode == '2'
                  },
                  GetKey : function(){return "Tuition"}
                },
                RowAdd : {
                  hide : true,
                  text : '학생자치경비',
                  c : function(d){
                    return d.UnivServiceId.IN(408403,408404,408405,408406)
                  },
                  GetKey : function(){return "AddAmount"}
                },
                RowPre : {
                  hide : true,
                  text : '예치금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "PreAmount"}
                },
                RowEnter : {
                  hide : true,
                  text : '입학금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "EnterAmount"}
                },
                RowTuition : {
                  hide : true,
                  text : '수업료계',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "Tuition"}
                },
                RowEnterScholarShip : {
                  hide : true,
                  text : '입학장학금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "EnterAmountScholarShip"}
                },
                RowTuitionScholarShip : {
                  hide : true,
                  text : '수업장학금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "TuitionScholarShip"}
                },
                RowSum : {
                  hide : true,
                  text : '전체금액합계',
                  c : function(d){
                    return d.UnivServiceId.IN(408406,408407)
                  },
                  GetKey : function(){return "PayAmount"}
                },
              },
        },
        mounted: function () {
            var that = this, url = location.pathname + "/GetStatistics";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: url,
                success: function (response) {
                    var data = JSON.parse(response.d);
                    that.Data = data.Table;
                    that.Loading = false;
                },
                error: function (err) {
                    console.warn(err);
                }
            });
        },
        methods: {
            GetResult : function(tbl, row, col){
                if(this.Loading) return 0;
                var data = this.Data.filter(function(d){
                    return tbl.c(d) && row.c(d) && col.c(d);
                });
                return col.result(data, row);
            },
            GetResultEtc : function(tbl, row, col){
              if(this.Loading) return 0;
              var data = this.Data.filter(function(d){
                  return tbl.c(d) && row.c(d) && col.c(d);
              });
              return col.resultEtc(data, row);
            },
        }
    });

})();
