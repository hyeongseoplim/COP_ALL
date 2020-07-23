var zero = ".";
// 숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function () {
    if (this == 0) return zero;
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    return n;
};
// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function () {
    var num = parseFloat(this);
    //if (isNaN(num) || num == "0") return ".";
    if (isNaN(num) || num == "0") return zero;
    return num.format();
};

Number.prototype.IN = function(){
  var arr = ($.isArray(arguments[0]) ? arguments[0] : Array.prototype.slice.call(arguments)), val = this.toString();
  return arr.filter(function(el){
      return el == val;
  }).length > 0;
}
String.prototype.IN = function(){
  var arr = ($.isArray(arguments[0]) ? arguments[0] : Array.prototype.slice.call(arguments)), val = this.toString();
  return arr.filter(function(el){
      return el == val;
  }).length > 0;
}

Array.prototype.GetItem = function (obj) {
    var Filter = Object.entries(obj);
    return this.filter(function (el) {
        var rtn = true;
        Filter.forEach(function(f){
            rtn = rtn & (el[f[0]] == f[1]);
        });
        return rtn;
    });
};

Array.prototype.Sum = function (key) {
    return this.reduce(function (ac, el) {
        if (el[key]) ac += parseInt(el[key],10);
        return ac;
    }, 0);
};
Array.prototype.Count = function (key) {
    return this.reduce(function (ac, el) {
        if (el[key]) ac++;
        return ac;
    }, 0);
};

String.prototype.right = function(n) {
  try{
      if (n <= 0)
          return "";
      else if (n > String(this).length)
          return this;
      else {
          var iLen = String(this).length;
          return String(this).substring(iLen, iLen - n);
      }
      
  }
  catch(e){
      return ".";
  }
};

Date.prototype.fullDate = function()
{
  var year = this.getFullYear();
  var month = ("0" + (this.getMonth() + 1)).right(2);
  var day	= ("0"+this.getDate()).right(2);
	return '' + year + '.' + month + '.' + day;
}


var Valid = {
    // Checks if the value is a number. This function does not consider NaN a
    // number like many other `isNumber` functions do.
    isNumber: function(value) {
      return typeof value === 'number' && !isNaN(value);
    },

    // Returns false if the object is not a function
    isFunction: function(value) {
      return typeof value === 'function';
    },

    // A simple check to verify that the value is an integer. Uses `isNumber`
    // and a simple modulo check.
    isInteger: function(value) {
      return v.isNumber(value) && value % 1 === 0;
    },

    // Checks if the value is a boolean
    isBoolean: function(value) {
      return typeof value === 'boolean';
    },

    // Uses the `Object` function to check if the given argument is an object.
    isObject: function(obj) {
      return obj === Object(obj);
    },

    // Simply checks if the object is an instance of a date
    isDate: function(obj) {
      return obj instanceof Date;
    },

    // Returns false if the object is `null` of `undefined`
    isDefined: function(obj) {
      return obj !== null && obj !== undefined;
    },

    isEmpty: function(value) {
      var attr;

      // Null and undefined are empty
      if (!v.isDefined(value)) {
        return true;
      }

      // functions are non empty
      if (v.isFunction(value)) {
        return false;
      }

      // Whitespace only strings are empty
      if (v.isString(value)) {
        return v.EMPTY_STRING_REGEXP.test(value);
      }

      // For arrays we use the length property
      if (v.isArray(value)) {
        return value.length === 0;
      }

      // Dates have no attributes but aren't empty
      if (v.isDate(value)) {
        return false;
      }

      // If we find at least one property we consider it non empty
      if (v.isObject(value)) {
        for (attr in value) {
          return false;
        }
        return true;
      }

      return false;
    },

    isString: function(value) {
      return typeof value === 'string';
    },
  
    isArray: function(value) {
      return {}.toString.call(value) === '[object Array]';
    },
  }

function PageMove(btn) {
    var url = $(btn).attr("url");
    location.replace(url);
}

function GetNowDate(){
  if(appStatistics == null) return;
  return appStatistics.GetNowDate;
}

function logout() {
    location.href = "Logout.aspx";
}

$(function(){
  var url = (location.pathname.toLowerCase().replace('/admin/4084/','') + location.search).toLowerCase();
  $("#TopBtn button").removeClass("btn-info").each(function(){
    var _this = $(this), r = _this.attr("url").toLowerCase();
    if(url == r) _this.addClass('btn-info');
  });
});


var Vue4084 = {
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
        text : '수시1',
        c : function(d){return d.RecruitTimeCode == '1'},
        result : function(data){
          return data.Count('ExamNo');
        }
      },
      Col2 : {
        text : '수시2',
        c : function(d){return d.RecruitTimeCode == '2'},
        result : function(data){
          return data.Count('ExamNo');
        }
      },
      Col3 : {
        text : '정시',
        c : function(d){return d.RecruitTimeCode == '3'},
        result : function(data){
          return data.Count('ExamNo');
        }
      },
      Col4 : {
        text : '자율',
        c : function(d){return d.UnivServiceId.IN(408423,408424,408427,408428,408429)},
        result : function(data){
          return data.Count('ExamNo');
        }
      },
      ColTotal : { 
        text : '계',
        c : function(d){return true},
        result : function(data){
          return data.Count('ExamNo');
        }
      },
      ColSum : {
        hide : true,
        text : '금액',
        c : function(d){return true},
        result : function(data, row){
          return data.Sum(row.GetKey());
          //return (sum == 0) ? '0원' : sum.format() + "원";
        },
        resultEtc : function(data, row){          
          var Amount = 0
          // if(data.UnivServiceId.IN(408403,408404,408405))
          // {
          //   Amount = data.Sum(row.GetKey()) + data.Sum(row.GetKey() + "ScholarShip") - data.Sum("PreAmount")
          // }
          // else
          // {
          //   Amount = data.Sum(row.GetKey()) + data.Sum(row.GetKey() + "ScholarShip")
          // }
          return data.Sum(row.GetKey()) + data.Sum(row.GetKey() + "ScholarShip");//Amount;
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
            return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429)
        },
        GetKey : function(){return "EnterAmount"}
      },
      Row2 : {
        cell2 : {text : '수업료', rowspan : 3},
        text : '예치금',
        amount : '300,000원',
        c : function(d){
          return d.UnivServiceId.IN(408401,408402)
        },
        GetKey : function(){return "PreAmount"}
      },
      Row3 : {
        hide : true,
        text : '공학,자연과학,예체능<br />(수시)',
        amount : '2,895,000원',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404) && d.CollegeCode != '2'
        },
        GetKey : function(){return "EnterAmount"}
      },
      Row4 : {
        hide : true,
        text : '인문사회<br />(수시)',
        amount : '2,326,000원',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404) && d.CollegeCode == '2'
        },
        GetKey : function(){return "Tuition"}
      },
      Row5 : {
        text : '공학,자연과학,예체능',
        amount : '3,195,000원',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429) && d.CollegeCode != '2'
        },
        GetKey : function(){return "Tuition"}
      },
      Row6 : {
        text : '인문사회계',
        amount : '2,626,000원',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429) && d.CollegeCode == '2'
        },
        GetKey : function(){return "Tuition"}
      },
      RowAdd : {
        hide : true,
        text : '학생자치경비',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429) && d.AddAmount > 0
        },
        GetKey : function(){return "AddAmount"}
      },
      RowPre : {
        hide : true,
        text : '예치금계',
        c : function(d){
          return d.UnivServiceId.IN(408401,408402)
        },
        GetKey : function(){return "PreAmount"}
      },
      RowEnter : {
        hide : true,
        text : '입학금계',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429)
        },
        GetKey : function(){return "EnterAmount"}
      },
      RowEnterScholarShip : {
        hide : true,
        text : '입학장학금계',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429)
        },
        GetKey : function(){return "EnterAmountScholarShip"}
      },
      RowTuitionScholarShip : {
        hide : true,
        text : '수업장학금계',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429)
        },
        GetKey : function(){return "TuitionScholarShip"}
      },
      RowTuition : {
        hide : true,
        text : '수업료계',
        c : function(d){
          return d.UnivServiceId.IN(408403,408404,408405,408423,408424,408427,408428,408429)
        },
        GetKey : function(){return "Tuition"}
      },
      RowSum : {
        hide : true,
        text : '전체금액합계',
        c : function(d){
          return d.UnivServiceId.IN(408401,408402,408403,408404,408405,408423,408424,408427,408428,408429)
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
    
    GetResultEtc : function(tbl, row, col){
      if(this.Loading) return 0;
      var data = this.Data.filter(function(d){
          return tbl.c(d) && row.c(d) && col.c(d);
      });
      return col.resultEtc(data, row);
    },
  }
};
