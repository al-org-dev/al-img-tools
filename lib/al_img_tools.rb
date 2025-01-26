require 'jekyll'

module AlImgTools
  # Library configurations
  LIBRARIES = {
    'img-comparison-slider' => {
      'integrity' => {
        'css' => 'sha256-3qTIuuUWIFnnU3LpQMjqiXc0p09rvd0dmj+WkpQXSR8=',
        'js' => 'sha256-EXHg3x1K4oIWdyohPeKX2ZS++Wxt/FRPH7Nl01nat1o=',
        'map' => 'sha256-3wfqS2WU5kGA/ePcgFzJXl5oSN1QsgZI4/edprTgX8w='
      },
      'url' => {
        'css' => 'https://cdn.jsdelivr.net/npm/img-comparison-slider@{{version}}/dist/styles.min.css',
        'js' => 'https://cdn.jsdelivr.net/npm/img-comparison-slider@{{version}}/dist/index.min.js',
        'map' => 'https://cdn.jsdelivr.net/npm/img-comparison-slider@{{version}}/dist/index.js.map'
      },
      'version' => '8.0.6'
    },
    'lightbox2' => {
      'integrity' => {
        'css' => 'sha256-uypRbsAiJcFInM/ndyI/JHpzNe6DtUNXaWEUWEPfMGo=',
        'js' => 'sha256-A6jI5V9s1JznkWwsBaRK8kSeXLgIqQfxfnvdOZEURY='
      },
      'url' => {
        'css' => 'https://cdn.jsdelivr.net/npm/lightbox2@{{version}}/dist/css/lightbox.min.css',
        'js' => 'https://cdn.jsdelivr.net/npm/lightbox2@{{version}}/dist/js/lightbox.min.js'
      },
      'version' => '2.11.5'
    },
    'medium_zoom' => {
      'integrity' => {
        'js' => 'sha256-ZgMyDAIYDYGxbcpJcfUnYwNevG/xi9OHKaR/8GK+jWc='
      },
      'url' => {
        'js' => 'https://cdn.jsdelivr.net/npm/medium-zoom@{{version}}/dist/medium-zoom.min.js'
      },
      'version' => '1.1.0'
    },
    'photoswipe' => {
      'integrity' => {
        'js' => 'sha256-VCBpdxvrNNxGHNuTdNqK9kPFkev2XY7DYzHdmgaB69Q='
      },
      'url' => {
        'css' => 'https://cdn.jsdelivr.net/npm/photoswipe@{{version}}/dist/photoswipe.min.css',
        'js' => 'https://cdn.jsdelivr.net/npm/photoswipe@{{version}}/dist/photoswipe.esm.min.js'
      },
      'version' => '5.4.4'
    },
    'photoswipe-lightbox' => {
      'integrity' => {
        'js' => 'sha256-uCw4VgT5DMdwgtjhvU9e98nT2mLZXcw/8WkaTrDd3RI='
      },
      'url' => {
        'js' => 'https://cdn.jsdelivr.net/npm/photoswipe@{{version}}/dist/photoswipe-lightbox.esm.min.js'
      },
      'version' => '5.4.4'
    },
    'swiper' => {
      'integrity' => {
        'css' => 'sha256-yUoNxsvX+Vo8Trj3lZ/Y5ZBf8HlBFsB6Xwm7rH75/9E=',
        'js' => 'sha256-BPrwikijIybg9OQC5SYFFqhBjERYOn97tCureFgYH1E=',
        'map' => 'sha256-lbF5CsospW93otqvWOIbbhj80CjazrZXvamD7nC7TBI='
      },
      'url' => {
        'css' => 'https://cdn.jsdelivr.net/npm/swiper@{{version}}/swiper-bundle.min.css',
        'js' => 'https://cdn.jsdelivr.net/npm/swiper@{{version}}/swiper-element-bundle.min.js',
        'map' => 'https://cdn.jsdelivr.net/npm/swiper@{{version}}/swiper-element-bundle.min.js.map'
      },
      'version' => '11.0.5'
    },
    'venobox' => {
      'integrity' => {
        'css' => 'sha256-ohJEB0/WsBOdBD+gQO/MGfyJSbTUI8OOLbQGdkxD6Cg=',
        'js' => 'sha256-LsGXHsHMMmTcz3KqTaWvLv6ome+7pRiic2LPnzTfiSo='
      },
      'url' => {
        'css' => 'https://cdn.jsdelivr.net/npm/venobox@{{version}}/dist/venobox.min.css',
        'js' => 'https://cdn.jsdelivr.net/npm/venobox@{{version}}/dist/venobox.min.js'
      },
      'version' => '2.1.8'
    }
  }

  class ImageToolsScriptsTag < Liquid::Tag
    def render(context)
      site = context.registers[:site]
      page = context.registers[:page]
      output = []

      # Image Layouts
      if page['images']
        # Image Comparison
        if page['images']['compare']
          output << <<~HTML
            <script
              defer
              src="#{LIBRARIES['img-comparison-slider']['url']['js'].sub('{{version}}', LIBRARIES['img-comparison-slider']['version'])}"
              integrity="#{LIBRARIES['img-comparison-slider']['integrity']['js']}"
              crossorigin="anonymous"
            ></script>
          HTML
        end

        # Gallery/Lightbox
        if page['images']['gallery']
          output << <<~HTML
            <script
              defer
              src="#{LIBRARIES['lightbox2']['url']['js'].sub('{{version}}', LIBRARIES['lightbox2']['version'])}"
              integrity="#{LIBRARIES['lightbox2']['integrity']['js']}"
              crossorigin="anonymous"
            ></script>
          HTML
        end

        # Medium Zoom
        if page['images']['medium_zoom']
          output << <<~HTML
            <!-- Medium Zoom JS -->
            <script
              defer
              src="#{LIBRARIES['medium_zoom']['url']['js'].sub('{{version}}', LIBRARIES['medium_zoom']['version'])}"
              integrity="#{LIBRARIES['medium_zoom']['integrity']['js']}"
              crossorigin="anonymous"
            ></script>
            <script defer src="{{ '/lib/assets/js/zoom.js' | relative_url | bust_file_cache }}"></script>
          HTML
        end

        # PhotoSwipe
        if page['images']['photoswipe']
          output << <<~HTML
            <script defer src="{{ '/lib/assets/js/photoswipe-setup.js' | relative_url | bust_file_cache }}" type="module"></script>
          HTML
        end

        # Slider
        if page['images']['slider']
          output << <<~HTML
            <script
              defer
              src="#{LIBRARIES['swiper']['url']['js'].sub('{{version}}', LIBRARIES['swiper']['version'])}"
              integrity="#{LIBRARIES['swiper']['integrity']['js']}"
              crossorigin="anonymous"
            ></script>
          HTML
        end

        # VenoBox
        if page['images']['venobox']
          output << <<~HTML
            <script
              defer
              src="#{LIBRARIES['venobox']['url']['js'].sub('{{version}}', LIBRARIES['venobox']['version'])}"
              integrity="#{LIBRARIES['venobox']['integrity']['js']}"
              crossorigin="anonymous"
            ></script>
            <script defer src="{{ '/lib/assets/js/venobox-setup.js' | relative_url | bust_file_cache }}" type="text/javascript"></script>
          HTML
        end
      end

      output.join("\n")
    end
  end
end

Liquid::Template.register_tag('al_img_tools_scripts', AlImgTools::ImageToolsScriptsTag)