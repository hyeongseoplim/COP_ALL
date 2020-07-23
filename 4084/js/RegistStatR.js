var appStatistics = null;
(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            Selection: {},
            MajorPersonnel : [],
            Data: []
        },
        mixins : [Vue4084],
        mounted: function () {
            var that = this;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/Admin/4084/RegistStatR.aspx/GetStatistics",
                success: function (response) {
                    var data = JSON.parse(response.d);
                    that.Data = data.Table;
                    that.Selection = data.Table1;
                    that.MajorPersonnel = data.Table2;
                    that.Loading = false;
                },
                error: function (err) {
                    console.warn(err);
                }
            });
        },
        computed: {

            IO: function () {
                return {
                    "I" : "정원내", 
                    "O": "정원외"
                };
            },
            
            Service: function () {
                if (!this.Selection.length) return [];
                var list = this.Selection.reduce(function (ac, d) {
                    var c = d.UnivServiceId, n = d.RecruitTimeName;
                    if (ac.filter(function (e) { return e.UnivServiceId == c }).length == 0) {
                        ac.push({
                            UnivServiceId: c,
                            ServiceName: n
                        });
                    }
                    return ac;
                }, []);
                list.sort(function (a, b) {
                    return a.UnivServiceId - b.UnivServiceId;
                });
                return list;
            },

            SelectionIO: function () {
                if (!this.Selection.length) return [];
                return this.Selection.reduce(function (ac, d) {
                    var io = d.SelectionTypeCode;
                    if (ac[io] === undefined) ac[io] = [];
                    ac[io].push(d);
                    return ac;
                }, {});
            },

            SelectionByCode: function () {
                return _.keyBy(this.Selection, "SelectionCode");
            },
            SelectionById: function () {
                return _.keyBy(this.Selection, "SelectionId");
            },

            RecruitPersonnel: function () {
                var sel = this.SelectionByCode;
                return this.MajorPersonnel.reduce(function (ac, d) {
                    var s = d.SelectionCode, io = (sel[s] || {}).SelectionTypeCode;
                    if (ac[io] === undefined) ac[io] = [];
                    ac[io].push(d)
                    return ac;
                }, []);
            },

        },
        methods: {

            GetRecruitPersonnel: function (io, service) {
                var data = this.RecruitPersonnel;
                if (!io && data['I']) return data["I"].Sum('Personnel') + data["O"].Sum('Personnel');
                if (!data[io]) return 0;
                if (!service) return data[io].Sum('Personnel');
                return data[io].filter(function (e) {
                    return e.UnivServiceId == service.UnivServiceId;
                }).Sum('Personnel');
            },

            GetPrevAccum: function (io, service) {
                var prev = this.T.TBL3, Selection = this.SelectionIO;
                return this.Data.filter(function(d){
                    var rtn = prev.c(d);
                    if (io) {
                        var sel = Selection[io];
                        rtn = rtn && sel.filter(function (s) { return s.SelectionId == d.SelectionId }).length > 0;
                    }
                    if (service) {
                        rtn = rtn && d.UnivServiceId == service.UnivServiceId;
                    }
                    return rtn;
                });
            },

            GetNowPay: function (io, service, row) {
                var now = this.T.TBL1, Selection = this.SelectionIO;
                return this.Data.filter(function (d) {
                    var rtn = now.c(d);
                    if (row) {
                        rtn = rtn && row.c(d);
                    }
                    if (io) {
                        var sel = Selection[io];
                        rtn = rtn && sel.filter(function (s) { return s.SelectionId == d.SelectionId }).length > 0;
                    }
                    if (service) {
                        rtn = rtn && d.UnivServiceId == service.UnivServiceId;
                    }
                    return rtn;
                });

                //return this.Data.filter(function(d){
                //    var mc = Major[d.MajorId], rtn = now.c(d) && row.c(d);
                //    if(Array.isArray(major)){
                //        rtn = rtn && major.filter(function(m){return m.MajorCode == mc.MajorCode}).length > 0;
                //    }
                //    else if(major){
                //        rtn = rtn && mc.MajorCode == major.MajorCode;
                //    }
                //    return rtn;
                //});
            },


        }
    });

})();