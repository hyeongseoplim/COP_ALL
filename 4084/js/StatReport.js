var AllData = null, appStatistics = null;
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



Array.prototype.Sum = function (key) {
    return this.reduce(function (ac, el) {
        if (el[key]) ac += parseInt(el[key],10);
        return ac;
    }, 0);
};


(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            Loading: true,
            NowDate : (new Date()),
            Data: []
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
        components:{
            vuejsDatepicker : vuejsDatepicker
        },
        filters: {
            digit: function (val) {
                return val.format();
            }
        },
        computed: {
            GetTitle : function(){
                return "2019학년도 2학기";
            },
            GetAllSelection : function(){
                return ['1','2','3','11','21'];
            },
            GetSelection : function(){
                var data = {
                    "수시1" : ['1'],
                    "수시2" : ['2'],
                    "정시" : ['3'],
                    "자율" : ['11','21']
                };
                return data;
            },
            GetNowDate : function(){
                return moment(this.NowDate).format('YYYYMMDD');
            },
            TodayPayData : function(){
                var date = this.GetNowDate;
                return this.Data.filter(function(d){
                    return d.PayDate == date && d.RegistStatus == 1;
                });
            },
            TodayRefundData : function(){
                var date = this.GetNowDate;
                return this.Data.filter(function(d){
                    return d.RefundCompDate == date && d.RefundStatus == 1;
                });
            },

            PrevPayData : function(){
                var date = this.GetNowDate;
                return this.Data.filter(function(d){
                    return d.PayDate < date && d.RegistStatus == 1 && d.RefundStatus == 0;
                });
            },
            
        },
        methods: {

            customFormatter : function(date){
                return moment(date).format('YYYY.MM.DD');
            }, 
        
            // 수입 / 반환 현황 - 예치금 건수
            GetPreCntByAmt : function(Flag, S){
                if(this.Loading) return 0;
                var RCodes = (S) ? this.GetSelection[S] : this.GetAllSelection;
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '예치금' && RCodes.indexOf(d.RecruitTimeCode) > -1;
                });
                return data.Count('ExamNo');
            },
            // 수입 / 반환 현황 - 예치금 합계
            GetPreAmountByAmt : function(Flag){
                if(this.Loading) return 0;
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '예치금';
                });
                return data.Sum('PreAmount').format() + " 원";
            },
            
            // 수입 / 반환 현황 - 수시 본등록 입학금 건수
            GetEnterCntByAmtS : function(Flag, S, S1){
                if(this.Loading) return 0; 
                var RCodes = (S) ? this.GetSelection[S] : [];
                if(S1) RCodes = RCodes.concat(this.GetSelection[S1] || []);
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '본등록' && RCodes.indexOf(d.RecruitTimeCode) > -1;
                });
                return data.Count('ExamNo');
            },
            // 수입 / 반환 현황 - 정시 본등록 입학금 건수
            GetEnterCntByAmtJ : function(Flag, S, S1){
                if(this.Loading) return 0; 
                var RCodes = (S) ? this.GetSelection[S] : [];
                if(S1) RCodes = RCodes.concat(this.GetSelection[S1] || []);
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '본등록' && RCodes.indexOf(d.RecruitTimeCode) > -1;
                });
                return data.Count('ExamNo');
            },
            // 수입 / 반환 현황 - 수시 / 정시 본등록 입학금 합계
            GetEnterAmountByAmt : function(Flag, S, S1){
                if(this.Loading) return 0;
                var RCodes = (S) ? this.GetSelection[S] : [];
                if(S1) RCodes = RCodes.concat(this.GetSelection[S1] || []);
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '본등록' && RCodes.indexOf(d.RecruitTimeCode) > -1;
                });
                return data.Sum('EnterAmount').format() + " 원";
            },

            // 수입 / 반환 현황 - 수시 / 정시 본등록 수업료 건수 - 모집단위계열별 (MG)
            GetTuitionCnt : function(Flag, MG, S){
                if(this.Loading) return 0; 
                var RCodes = (S) ? this.GetSelection[S] : [];
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '본등록' && RCodes.indexOf(d.RecruitTimeCode) > -1 && d.MajorGroup == MG;
                });
                return data.Count('ExamNo');
            },
            // 수입 / 반환 현황 - 수시 / 정시 본등록 수업료 합계 - 모집단위계열별 (MG)
            GetTuitionAmount : function(Flag, MG, S){
                if(this.Loading) return 0;
                var RCodes = (S) ? this.GetSelection[S] : [];
                var data = ((Flag == 1) ? this.TodayPayData : this.TodayRefundData).filter(function(d){
                    return d.PayType == '본등록' && RCodes.indexOf(d.RecruitTimeCode) > -1 && d.MajorGroup == MG;
                });
                return data.Sum('Tuition').format() + " 원";
            },

            
            // 3. 집계표 - 예치금 전일누계
            GetPreCntAcc : function(Flag){
                if(this.Loading) return 0;
                var data = this.PrevPayData.filter(function(d){
                    return d.PayType == '예치금';
                });
                return data.Count('ExamNo');
            },
            // 3. 집계표 - 예치금 전일누계 합계금액
            GetPreAmountAcc : function(Flag){
                if(this.Loading) return 0;
                var data = this.PrevPayData.filter(function(d){
                    return d.PayType == '예치금';
                });
                return data.Sum('PreAmount').format() + " 원";
            },
            // 3. 집계표 - 입학금 전일누계
            GetEnterCntAcc : function(Flag){
                if(this.Loading) return 0;
                var data = this.PrevPayData.filter(function(d){
                    return d.PayType == '본등록';
                });
                return data.Count('ExamNo');
            },
            // 3. 집계표 - 입학금 전일누계 합계금액
            GetEnterAmountAcc : function(Flag){
                if(this.Loading) return 0;
                var data = this.PrevPayData.filter(function(d){
                    return d.PayType == '본등록';
                });
                return data.Sum('EnterAmount').format() + " 원";
            },
            // 3. 집계표 - 수업료 전일누계
            GetTuitionCntAcc : function(Flag){
                if(this.Loading) return 0;
                var data = this.PrevPayData.filter(function(d){
                    return d.PayType == '본등록';
                });
                return data.Count('ExamNo');
            },
            // 3. 집계표 - 수업료 전일누계 합계금액
            GetTuitionAmountAcc : function(Flag){
                if(this.Loading) return 0;
                var data = this.PrevPayData.filter(function(d){
                    return d.PayType == '본등록';
                });
                return data.Sum('Tuition').format() + " 원";
            },




        }
    });

})();