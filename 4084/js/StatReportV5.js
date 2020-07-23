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
                c : function(d){return d.UnivServiceId.IN(408410)},
                result : function(data){
                  return data.Count('ExamNo');
                }
              },
              Col2 : {
                text : '추가',
                c : function(d){return d.UnivServiceId.IN(408411)},
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
                    return d.UnivServiceId.IN(408410)
                  },
                  GetKey : function(){return "EnterAmount"}
                },
                Row2 : {
                  cell2 : {text : '수업료', rowspan : 3},        
                  cell3 : {text : '공학, 자연과학, 예체능', rowspan : 2},
                  text : '2학년',
                  amount : '3,109,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.CollegeCode != '2' && d.Tuition == "3109000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row3 : {
                  hide:false,
                  text : '3학년',
                  amount : '2,990,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.CollegeCode != '2' && d.Tuition == "2990000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row4 : {
                  hide:false,
                  cell3 : {text : '인문사회'},
                  text : '2학년',
                  amount : '2,555,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.CollegeCode == '2' && d.Tuition == "2555000"
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row5 : {     
                  hide: true,                               
                  text : '2년제',
                  amount : '2,626,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.CollegeCode == '3'
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row6 : {
                  hide : true,
                  cell3 : {text : '인문사회계', rowspan:2},
                  text : '1년제',
                  amount : '2,427,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.CollegeCode == '2'
                  },
                  GetKey : function(){return "Tuition"}
                },
                Row7 : {
                  hide : true,
                  text : '2년제',
                  amount : '2,626,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.CollegeCode == '2'
                  },
                  GetKey : function(){return "Tuition"}
                },
                RowAdd : {
                  hide : true,
                  text : '학생자치경비',
                  amount : '14,000원',
                  c : function(d){
                    return d.UnivServiceId.IN(408410) && d.AddAmount > 0
                  },
                  GetKey : function(){return "AddAmount"}
                },
                RowPre : {
                  hide : true,
                  text : '예치금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408410)
                  },
                  GetKey : function(){return "PreAmount"}
                },
                RowEnter : {
                  hide : true,
                  text : '입학금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408410)
                  },
                  GetKey : function(){return "EnterAmount"}
                },
                RowTuition : {
                  hide : true,
                  text : '수업료계',
                  c : function(d){
                    return d.UnivServiceId.IN(408410)
                  },
                  GetKey : function(){return "Tuition"}
                },
                RowEnterScholarShip : {
                  hide : true,
                  text : '입학장학금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408410)
                  },
                  GetKey : function(){return "EnterAmountScholarShip"}
                },
                RowTuitionScholarShip : {
                  hide : true,
                  text : '수업장학금계',
                  c : function(d){
                    return d.UnivServiceId.IN(408410)
                  },
                  GetKey : function(){return "TuitionScholarShip"}
                },
                RowSum : {
                  hide : true,
                  text : '전체금액합계',
                  c : function(d){
                    return d.UnivServiceId.IN(408410)
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


/*
var Vue4084_1 = {
    data: {
      Loading: true,
      NowDate : (new Date()),
      
      T : {
        TBL1 : {
          text : '수입',
          c : function(d){
            return d.PayDate == GetNowDate() && d.RegistStatus == 1
          }
        },
        TBL2 : {
          text : '반환',
          c : function(d){
            return d.RefundCompDate == GetNowDate() && d.RefundStatus == 1
          }
        },
        TBL3 : {
          hide : true,
          text : '전일누계',
          c : function(d){
            return d.PayDate < GetNowDate() && d.RegistStatus == 1;
          }
        },
        TBL4 : { 
            hide : true,
            text : '전일환불',
            c : function(d){
                return (d.RefundCompDate < GetNowDate() && d.RefundStatus == 1);
            }
        },
        TBL5 : {
          hide : true,
          text : '전체합계',
          c : function(d){
              return (d.PayDate < GetNowDate() && d.RegistStatus == 1) || (d.PayDate == GetNowDate() && d.RegistStatus == 1 && d.RefundStatus == 0);
          }
        }
      },
      C : {
        Col1 : {
          text : '최초',
          c : function(d){return d.UnivServiceId.IN(408406,408408)},
          result : function(data){
            return data.Count('ExamNo');
          }
        },
        Col2 : {
          text : '추가',
          c : function(d){return d.UnivServiceId.IN(408407,408409)},
          result : function(data){
            return data.Count('ExamNo');
          }
        },
        ColSum : {
          hide : true,
          text : '합계',
          c : function(d){return true},
          result : function(data, row){
            return data.Sum(row.GetKey());
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
            return d.UnivServiceId.IN(408406,408407,408408,408409)
          },
          GetKey : function(){return "EnterAmount"}
        },
        Row2 : {
          cell2 : {text : '수업료', rowspan : 6},        
          cell3 : {text : '공학계', rowspan : 2},
          text : '1년제',
          amount : '2,953,000원',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409) && d.CollegeCode == '1'
          },
          GetKey : function(){return "Tuition"}
        },
        Row3 : {
          text : '2년제',
          amount : '2,895,000원',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409) && d.CollegeCode == '1'
          },
          GetKey : function(){return "Tuition"}
        },
        Row4 : {
          cell3 : {text : '자연과학계', rowspan:1},
          text : '1년제',
          amount : '2,953,000원',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409) && d.CollegeCode == '3'
          },
          GetKey : function(){return "Tuition"}
        },
        Row5 : {
          cell3 : {text : '예체능계', rowspan:1},
          text : '2년제',
          amount : '3,195,000원',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409) && d.CollegeCode == '4'
          },
          GetKey : function(){return "Tuition"}
        },
        Row6 : {
          cell3 : {text : '인문사회계', rowspan:2},
          text : '1년제',
          amount : '2,427,000원',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409) && d.CollegeCode == '2'
          },
          GetKey : function(){return "Tuition"}
        },
        Row7 : {
          text : '2년제',
          amount : '2,626,000원',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409) && d.CollegeCode == '2'
          },
          GetKey : function(){return "Tuition"}
        },
        
        RowPre : {
          hide : true,
          text : '예치금계',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409)
          },
          GetKey : function(){return "PreAmount"}
        },
        RowEnter : {
          hide : true,
          text : '입학금계',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409)
          },
          GetKey : function(){return "EnterAmount"}
        },
        RowTuition : {
          hide : true,
          text : '수업료계',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409)
          },
          GetKey : function(){return "Tuition"}
        },
        RowSum : {
          hide : true,
          text : '전체금액합계',
          c : function(d){
            return d.UnivServiceId.IN(408406,408407,408408,408409)
          },
          GetKey : function(){return "PayAmount"}
        },
      },
    },
    filters : {
      digit: function (val) {
        return val.format();
      }
    },
    created : function(){
    },
    components:{
      vuejsDatepicker : vuejsDatepicker
    },
    computed : {
      GetTitle : function(){
        return "2020학년도 1학기";
      },
      GetNowDate : function(){
        return moment(this.NowDate).format('YYYYMMDD');
      },
    },
    methods : {
      customFormatter : function(date){
        return moment(date).format('YYYY.MM.DD');
      },
    }
  };
*/  