var appStatistics = null;
(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            AmountById: {},
            MajorById: {},
            StartDate: (new Date()),
            EndDate: (new Date()),
            RefundStatus : "1",
            Data: [],
            Type : ""
        },
        mounted: function () {
            var that = this;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/Admin/4084/RefundListAdd.aspx/GetStatistics",
                success: function (response) {
                    var data = JSON.parse(response.d);
                    that.Amount = _.keyBy(data.Table1, "SRSID");
                    that.MajorById = _.keyBy(data.Table2, "MajorId");
                    that.Data = data.Table;
                    that.Loading = false;
                },
                error: function (err) {
                    console.warn(err);
                }
            });
        },
        mixins: [Vue4084],
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
            GetDataByDate: function (major) {
                var start = moment(this.StartDate).format('YYYYMMDD'), end = moment(this.EndDate).format('YYYYMMDD');                
                var stat = this.RefundStatus;
                var t = this.Type;
                return this.Data.filter(function (e) {
                    if(t == '') return e.RefundStatus == stat && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) >= start && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) <= end;
                    if(t == 0) return [408401, 408402].indexOf(e.UnivServiceId) > -1 
                                                && e.RefundStatus == stat
                                                && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) >= start 
                                                && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) <= end;
                    if(t == 1) return [408403, 408404, 408405,408423].indexOf(e.UnivServiceId) > -1 
                                                && e.RefundStatus == stat
                                                && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) >= start 
                                                && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) <= end;
                    return e.RecruitTimeCode == t && e.RefundStatus == stat && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) >= start && (stat == '2' ? e.RefundProcDate : e.RefundCompDate) <= end;
                });
            },
        },
        methods: {
            GetAmount: function (d, k) {
                var amt = this.Amount[d.SRSID];
                if (k) return amt[k];
                return amt['PayAmount'] || 0;
            },
            GetSumAmount: function (k) {
                var amt = this.Amount;
                return this.GetDataByDate.reduce(function(ac, d){
                    ac += amt[d.SRSID][k];
                    return ac;
                }, 0);
            },
        }
    });

})();