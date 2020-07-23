var AllData = null, appStatistics = null;
// 숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function () {
    if (this == 0) return ".";
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    return n;
};

// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function () {
    var num = parseFloat(this);
    if (isNaN(num) || num == "0") return ".";
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
            Data: [],
            Type : '',
            button_active : false
        },
        mounted: function () {
            var that = this;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/Admin/4084/RegistMajorStat.aspx/GetStatistics",
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
        filters: {
            digit: function (val) {
                return val.format();
            }
        },
        computed: {

        },
        methods: {

            GetDataByMajorId: function () {
                var t = this.Type;
                return this.Data.filter(function(d){
                    if(t == '') return d;
                    if(t == 0) return [408401, 408402].indexOf(d.UnivServiceId) > -1;
                    if(t == 1) return [408403, 408404].indexOf(d.UnivServiceId) > -1;
                    return d.RecruitTimeCode == t;
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