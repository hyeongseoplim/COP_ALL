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
            MajorById: {},
            SelectionById: {},
            Personnel: [],
            Data: [],
            Type : ''
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
                    that.MajorById = _.keyBy(data.Table1, "MajorId");
                    that.SelectionById = _.keyBy(data.Table2, "SelectionId");
                    that.Personnel = data.Table3;
                    that.Data = data.Table.map(function(d){
                        var m = d.MajorId, s = d.SelectionId;
                        return {
                            UnivServiceId : d.UnivServiceId,
                            MajorCode : that.MajorById[m].MajorCode,
                            SelectionCode : that.SelectionById[s].SelectionCode,
                            ExamNo : d.ExamNo,
                            RegistStatus : d.RegistStatus
                        };
                    });
                    that.Loading = false;
                },
                error: function (err) {
                    console.warn(err);
                }
            });
        },
        filters: {
            digit: function (val) {
                return val.format();
            }
        },
        computed: {
            GetTitle : function(){
                return "2020학년도 1학기";
            },

            GetRecruitTime : function(){
                var t = this.Type;
                var Rdata = Object.entries(this.SelectionById).filter(function(d){
                    if(t == '') return d;
                    if(t == 0) return [408401, 408402].indexOf(d[1].UnivServiceId) > -1;
                    if(t == 1) return [408403, 408404, 408405].indexOf(d[1].UnivServiceId) > -1;
                    return d.RecruitTimeCode == t;
                }).reduce(function(ac, el){
                    var R = el[1].UnivServiceId;
                    if(ac[R] === undefined) ac[R] = el[1].RecruitTimeName;
                    return ac;
                }, {});
                return Rdata;
            },

            GetSelection : function(){
                var data = {
                    "정원내" : {
                        "일반전형" : ['10','11','12'],
                        "특별(일반)" : ['24'],
                        "특별(특성화)" : ['13'],
                        "대학자체" : ['27']
                    },
                    "정원외" : {
                        "대졸전형" : ['20'],
                        "농어촌" : ['52'],
                        "기초" : ['54'],
                        "새터민" : ['57']
                    }
                };
                return data;
            },

        },
        methods: {


            GetMajor : function(UnivServiceId){
                if(this.Loading) return [];
                var data = Object.entries(this.MajorById).reduce(function(ac, d){
                    var major = d[1], t = major.MajorType;
                    if(major.UnivServiceId != UnivServiceId) return ac;
                    if(ac[t] === undefined) ac[t] = [];
                    ac[t].push(major);
                    return ac;
                }, {});
                return data;
            },


            GetPerByM : function(d, M){
                if(this.Loading) return [];
                return d.reduce(function(ac, data){
                    if(M.indexOf(data.MajorCode) > -1) ac.push(data);
                    return ac;
                }, []);
            },

            GetPerByS : function(d, S){
                if(this.Loading) return [];
                return d.reduce(function(ac, data){
                    if(S.indexOf(data.SelectionCode) > -1) ac.push(data);
                    return ac;
                }, []);
            },

            GetPerByMS : function(d, M, S){
                if(this.Loading) return [];
                if(M === undefined) return this.GetPerByS(d, S);
                if(S === undefined) return this.GetPerByM(d, M);
                return d.reduce(function(ac, data){
                    var s = data.SelectionCode, m = data.MajorCode;
                    if(S.indexOf(s) > -1 && M.indexOf(m) > -1) ac.push(data);
                    return ac;
                }, []);
            },

            Parse : function(M, S){
                var p = {};
                p.ml = M;
                p.sl = S;
                if(Array.isArray(M)) p.ml = M.map(function(major){return major.MajorCode});
                if(typeof M == 'string') p.ml = [M];
                if(typeof S == 'string') p.sl = [S];
                if(Valid.isObject(S)) p.sl = Object.entries(S).reduce(function(ac, s){ac = ac.concat(s[1]);return ac;}, []);
                return p;
            },

            PerById : function(UnivServiceId){
                return this.Personnel.filter(function(d){
                    return d.UnivServiceId == UnivServiceId;
                });
            },

            GetPersonnel: function (UnivServiceId, M, S) {
                if(this.Loading) return 0;
                var p = this.Parse(M, S);
                if(M === undefined && S === undefined) return this.PerById(UnivServiceId).Sum('Personnel');
                return this.GetPerByMS(this.PerById(UnivServiceId), p.ml, p.sl).Sum('Personnel');
            },

            GetPayCnt: function (UnivServiceId, M, S) {
                if(this.Loading) return 0;
                var p = this.Parse(M, S), data = this.Data.filter(function(d){return d.UnivServiceId == UnivServiceId && d.RegistStatus == 1});
                if(M === undefined && S === undefined) return data.Count('ExamNo');
                return this.GetPerByMS(data, p.ml, p.sl).Count('ExamNo');
            },
            GetUnPayCnt: function (UnivServiceId, M, S) {
                if(this.Loading) return 0;
                var p = this.Parse(M, S), data = this.Data.filter(function(d){return d.UnivServiceId == UnivServiceId && d.RegistStatus == 0});
                if(M === undefined && S === undefined) return data.Count('ExamNo');
                return this.GetPerByMS(data, p.ml, p.sl).Count('ExamNo');
            },
            GetRatio: function (UnivServiceId, M, S) {
                if(this.Loading) return 0;
                var p = this.Parse(M, S);
                var dataP = this.Data.filter(function(d){return d.UnivServiceId == UnivServiceId && d.RegistStatus == 1});
                var dataA = this.Data.filter(function(d){return d.UnivServiceId == UnivServiceId});

                var pay = 0, unpay = 0;
                if(M === undefined && S === undefined) {
                    pay = dataP.Count('ExamNo');
                    unpay = dataA.Count('ExamNo');
                }
                else{
                    pay = this.GetPerByMS(dataP, p.ml, p.sl).Count('ExamNo');
                    unpay = this.GetPerByMS(dataA, p.ml, p.sl).Count('ExamNo');
                }
                return (pay / (unpay == 0 ? 1 : unpay) * 100).toFixed(2) + "%";
            }
        }
    });

})();