var appStatistics = null;
(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            MajorById: {},
            Data: [],
            Type : ''
        },
        mounted: function () {
            var that = this;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/Admin/4084/RefundStat.aspx/GetStatistics",
                success: function (response) {
                    var data = JSON.parse(response.d);
                    that.MajorById = _.keyBy(data.Table1, "MajorId");
                    that.Data = data.Table;
                    
                    // console.log(data.Table);
                    // var t = that.Type;
                    // that.Data = data.Table.filter(function (e) {
                    //     if(t == '') return true;
                    //     if(t == 0) return [408401, 408402].indexOf(e.UnivServiceId) > -1;
                    //     if(t == 1) return [408403, 408404].indexOf(e.UnivServiceId) > -1;
                    //     return e.RecruitTimeCode == t;
                    // });
                    that.Loading = false;
                },
                error: function (err) {
                    console.warn(err);
                }
            });
        },
        mixins : [Vue4084],
        computed : {
            GetData : function(){
                var t = this.Type;
                return this.Data.filter(function (e) {
                    if(t == '') return true;
                    if(t == 0) return [408401, 408402].indexOf(e.UnivServiceId) > -1;
                    if(t == 1) return [408403, 408404, 408405,408423].indexOf(e.UnivServiceId) > -1;
                    return e.RecruitTimeCode == t;
                });
            }
        },
        methods: {

            GetDataByMajorId: function (major) {
                return this.Data.filter(function (e) {
                    return e.UnivServiceId == major.UnivServiceId && e.MajorId == major.MajorId;
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