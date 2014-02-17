// add target about to outer link
(function(){
    $(function(){
        $("a[href^='http']:not([href^='" + location.protocol + "//" + location.host + "'])").attr('target', '_blank');
    });
})();
