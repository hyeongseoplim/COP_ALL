var appStatistics = null;
(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            AmountData: [],
            StartDate: (new Date()),
            EndDate: (new Date()),
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
                url: "/Admin/4084/RegistStatA.aspx/GetStatistics",
                success: function (response) {
                    var data = JSON.parse(response.d);
                    that.Data = data.Table;
                    that.AmountData = data.Table1;
                    that.Loading = false;
                },
                error: function (err) {
                    console.warn(err);
                }
            });
        },
        filters: {
        },
        computed: {

            GetStartDate: {
                get: function () {
                    return this.StartDate || (new Date());
                },
                set: function (val) {
                    if (this.EndDate < val) this.EndDate = val;
                    this.StartDate = val;
                }
            },
            GetEndDate: {
                get: function () {
                    return this.EndDate || (new Date());
                },
                set: function (val) {
                    if (this.StartDate > val) this.StartDate = val;
                    this.EndDate = val;
                }
            },
            
            AmtID: function () {
                return _.keyBy(this.AmountData, "SRSID");
            },

            GetAmountData: function () {
                var start = moment(this.StartDate).format('YYYYMMDD'), end = moment(this.EndDate).format('YYYYMMDD');
                var t = this.Type;
                return this.Data.filter(function (e) {
                    if(t == '') return e.PayDate >= start && e.PayDate <= end;
                    if(t == 0) return [408401, 408402].indexOf(e.UnivServiceId) > -1 && e.PayDate >= start && e.PayDate <= end;
                    if(t == 1) return [408403, 408404,408405,408423].indexOf(e.UnivServiceId) > -1 && e.PayDate >= start && e.PayDate <= end;
                    return e.RecruitTimeCode == t && e.PayDate >= start && e.PayDate <= end;
                });
            },

            SumAmt : function(){
                if(this.AmountData.length == 0) return [];
                var target = this.GetAmountData;
                return this.AmountData.filter(function(d){
                    return target.filter(function(t){return d.SRSID == t.SRSID}).length > 0;
                });
            },

        },
        methods: {

        }
    });

})();