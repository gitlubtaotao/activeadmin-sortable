(function ($) {
    $(document).ready(function () {
        $('.handle').closest('tbody').activeAdminSortable();
        $positionAarry = [];
        //进行数据倒序
        var length = $(".handle").each(function (index,value) {
            $positionAarry[index] = $(this).attr('position');
            console.log($positionAarry);
        });
    });
    $.fn.activeAdminSortable = function () {
        this.sortable({
            update: function (event, ui) {
                var url = ui.item.find('[data-sort-url]').data('sort-url');
                var item = ui.item.index();
                var position = $positionAarry[item];
                $.ajax({
                    url: url,
                    type: 'post',
                    data: {position: position},
                    success: function () {
                        window.location.reload()
                    }
                });
            }
        });
        this.disableSelection();
    }
})(jQuery);
