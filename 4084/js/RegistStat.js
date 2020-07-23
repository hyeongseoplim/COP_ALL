var appStatistics = null;
(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            PageType : PageType,
            Loading: true,
            MajorById: {},
            MajorPersonnel : [],
            Data: [],
            Type : ''
        },
        mixins : [Vue4084],
        mounted: function () {
            var that = this;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/Admin/4084/RegistStat.aspx/GetStatistics",
                success: function (response) {
                    var data = JSON.parse(response.d);
                    console.log(data);
                    that.MajorById = _.keyBy(data.Table1, "MajorId");
                    that.Data = data.Table;
                    that.MajorPersonnel = data.Table2;
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

            MajorPersonnelByCode : function(){
                return _.keyBy(this.MajorPersonnel, "MajorCode");
            },

            JY : function(){
                return ["주간", "야간"];
            },

            MajorOrderJY : function(){
                var list = Object.entries(this.MajorById).reduce(function(ac, el){
                    var d = el[1], c = d.MajorCode, n = d.MajorName;
                    if(ac.filter(function(e){return e.MajorCode == c}).length == 0){
                        ac.push({
                            MajorCode : c,
                            MajorName : n,
                            Type : (n.indexOf("(야") == -1) ? "주간" : "야간"
                        });
                    }
                    return ac;
                }, []);
                list.sort(function(a, b){
                    if(a.Type == b.Type) return a.MajorCode - b.MajorCode;
                    return (a.Type > b.Type) ? -1 : (a.Type < b.Type) ? 1 : 0;
                });
                return list;
            },

            GetFilterData : function(){
                var t = this.Type;
                return this.Data.filter(function (e) {
                    if(t == '') return true;
                    if(t == 0) return [408401, 408402].indexOf(e.UnivServiceId) > -1;
                    if(t == 1) return [408403, 408404,408405,408423].indexOf(e.UnivServiceId) > -1;
                    return e.RecruitTimeCode == t;
                });
            }

        },
        methods: {

            GetMajorPersonnelByJY : function(jy){
                var data = this.MajorPersonnel.reduce(function(ac, d){
                    var type = (d.MajorName.indexOf("(야") == -1) ? "주간" : "야간";
                    if(ac[type] === undefined) ac[type] = [];
                    ac[type].push(d)
                    return ac;
                }, []);
                if(!data[jy]) return 0;
                return data[jy].Sum('Personnel');
            },

            GetMajor : function(jy){
                return this.MajorOrderJY.filter(function(e){
                    return e.Type == jy;
                });
            },

            GetDataByMajorId: function (major) {
                return this.GetFilterData.filter(function(e){
                    return e.MajorId == major.MajorId;
                });
            },

            GetPrevAccum : function(major){
                var prev = this.T.TBL3, Major = this.MajorById;
                return this.Data.filter(function(d){
                    var mc = Major[d.MajorId], rtn = prev.c(d);
                    if(Array.isArray(major)){
                        rtn = rtn && major.filter(function(m){return m.MajorCode == mc.MajorCode}).length > 0;
                    }
                    else if(major){
                        rtn = rtn && mc.MajorCode == major.MajorCode;
                    }
                    return rtn;
                });
            },

            GetNowRefund : function(major, row){
                var now = this.T.TBL2, Major = this.MajorById;
                return this.Data.filter(function(d){
                    var mc = Major[d.MajorId], rtn = now.c(d) && row.c(d);
                    if(Array.isArray(major)){
                        rtn = rtn && major.filter(function(m){return m.MajorCode == mc.MajorCode}).length > 0;
                    }
                    else if(major){
                        rtn = rtn && mc.MajorCode == major.MajorCode;
                    }
                    return rtn;
                });
            },

            DisplayBirthday: function (ssn) {
                var Year; 
                if (ssn.split('-')[0].substring(0, 1) == 9) {
                    Year = '19' + ssn.split('-')[0].substring(0, 2);
                }
                else {
                    Year = '20' + ssn.split('-')[0].substring(0, 2);
                }
                var Month = 0;
                var Day =0;
                return Year+ "." + ssn.split('-')[0].substring(2, 4) + "." + ssn.split('-')[0].substring(4, 6);
            },
            DisplayGender: function (ssn) {
                if (ssn.split('-')[1] == '1' || ssn.split('-')[1] == '3')
                    return '남';
                else return '여';
            },

            DisplayNowDate: function () {

                function getTimeStamp() {
                    var d = new Date();
                    var s =
                      leadingZeros(d.getFullYear(), 4) + '-' +
                      leadingZeros(d.getMonth() + 1, 2) + '-' +
                      leadingZeros(d.getDate(), 2) + ' ' +

                      leadingZeros(d.getHours(), 2) + ':' +
                      leadingZeros(d.getMinutes(), 2) + ':' +
                      leadingZeros(d.getSeconds(), 2);

                    return s;
                }

                function leadingZeros(n, digits) {
                    var zero = '';
                    n = n.toString();

                    if (n.length < digits) {
                        for (i = 0; i < digits - n.length; i++)
                            zero += '0';
                    }
                    return zero + n;
                }
                return getTimeStamp();

            },


        }
    });

})();