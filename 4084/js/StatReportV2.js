var appStatistics = null;


(function(){
    appStatistics = new Vue({
        el: '#Stat',
        data: {
            Data: []
        },
        mixins : [Vue4084],
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

        }
    });

})();