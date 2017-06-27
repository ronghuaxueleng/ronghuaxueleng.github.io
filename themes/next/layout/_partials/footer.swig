<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
</div>
{% if theme.busuanzi_count %}
<!-- 不蒜子 -->
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<span id="busuanzi_container_site_pv" style="display:none">
  本站访客数<span id="busuanzi_value_site_uv"></span>人次
</span>
<!-- 不蒜子计数初始值纠正 -->
<script src="//cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        var int = setInterval(fixCount, 100);
        var busuanziSiteOffset = parseInt({{ theme.busuanzi_site_offset }});
        function fixCount() {
            if ($("#busuanzi_container_site_pv").css("display") != "none") {
                clearInterval(int);
                $("#busuanzi_value_site_uv").html(parseInt($("#busuanzi_value_site_uv").html()) + busuanziSiteOffset);
            }
        }
    });
</script>
{% endif %}
