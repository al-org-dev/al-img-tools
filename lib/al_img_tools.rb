require 'jekyll'

module AlImgTools
  # Directory structure constants
  PLUGIN_NAME = 'al_img_tools'
  ASSETS_DIR = 'assets'
  JS_DIR = 'js'
  JS_FILES = ['zoom.js', 'venobox-setup.js'].freeze

  # Custom StaticFile class to track when files are written
  class PluginStaticFile < Jekyll::StaticFile
    def write(dest)
      Jekyll.logger.debug("AlImgTools:", "Attempting to copy from #{path} to #{destination(dest)}")
      super(dest).tap do |result|
        if result
          Jekyll.logger.info("AlImgTools:", "Successfully copied #{name} from #{path} to #{destination(dest)}")
        else
          Jekyll.logger.error("AlImgTools:", "Failed to copy #{name} from #{path}")
        end
      end
    end
  end

  class AssetsGenerator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      # Get the plugin's assets directory path - now includes the full desired structure
      plugin_lib_path = File.expand_path('.', __dir__)
      Jekyll.logger.info("AlImgTools:", "Plugin lib directory: #{plugin_lib_path}")

      # Register each JS file
      JS_FILES.each do |js_file|
        # Construct source path - now includes the full path structure we want in the output
        source_path = File.join(plugin_lib_path, ASSETS_DIR, PLUGIN_NAME, JS_DIR, js_file)
        Jekyll.logger.info("AlImgTools:", "Looking for source file: #{source_path}")

        # Only add the file if it exists
        if File.exist?(source_path)
          # Create a static file with:
          # - site: the Jekyll site instance
          # - base: the base directory containing the file
          # - dir: the directory relative to base (used to construct the destination path)
          # - name: the file name
          static_file = PluginStaticFile.new(
            site,
            plugin_lib_path,                            # base directory
            File.join(ASSETS_DIR, PLUGIN_NAME, JS_DIR), # source dir relative to base
            js_file                                     # filename
          )

          # The file will be copied to: _site/assets/al_img_tools/js/[filename]
          site.static_files << static_file
          Jekyll.logger.info("AlImgTools:", "Registered #{js_file} for copying to #{ASSETS_DIR}/#{PLUGIN_NAME}/#{JS_DIR}/")
        else
          Jekyll.logger.warn("AlImgTools:", "JavaScript file not found: #{source_path}")
        end
      end
    end
  end

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
    'spotlight' => {
      'integrity' => {
        'css' => 'sha256-Dsvkx8BU8ntk9Iv+4sCkgHRynYSQQFP6gJfBN5STFLY='
      },
      'url' => {
        'css' => 'https://cdn.jsdelivr.net/npm/spotlight.js@{{version}}/dist/css/spotlight.min.css',
        'js' => 'https://cdn.jsdelivr.net/npm/spotlight.js@{{version}}/dist/spotlight.bundle.min.js'
      },
      'version' => '0.7.8'
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

  class BaseImageToolsTag < Liquid::Tag
    private

    def page_images(context)
      page = context.registers[:page]
      images = page && page['images']
      images.is_a?(Hash) ? images : {}
    end

    def base_url(context)
      site = context['site']
      site && site['baseurl'] ? site['baseurl'] : ''
    end

    def medium_zoom_enabled?(context, images)
      site = context['site']
      site_enabled = site && site['enable_medium_zoom']
      !!(site_enabled || images['medium_zoom'])
    end

    def lightbox_enabled?(images)
      !!(images['lightbox2'] || images['gallery'])
    end

    def asset_url(context, file_name)
      "#{base_url(context)}/#{ASSETS_DIR}/#{PLUGIN_NAME}/#{JS_DIR}/#{file_name}"
    end

    def library_url(library, asset_type)
      library_cfg = LIBRARIES[library]
      return nil unless library_cfg

      url = library_cfg.dig('url', asset_type)
      return nil unless url

      url.sub('{{version}}', library_cfg['version'])
    end

    def library_integrity(library, asset_type)
      LIBRARIES.dig(library, 'integrity', asset_type)
    end
  end

  class ImageToolsStylesTag < BaseImageToolsTag
    def render(context)
      images = page_images(context)
      output = []

      if images['compare']
        output << <<~HTML
          <!-- Image comparison slider -->
          <link
            rel="stylesheet"
            href="#{library_url('img-comparison-slider', 'css')}"
            integrity="#{library_integrity('img-comparison-slider', 'css')}"
            crossorigin="anonymous"
          >
        HTML
      end

      if lightbox_enabled?(images)
        output << <<~HTML
          <!-- Lightbox2 -->
          <link
            rel="stylesheet"
            href="#{library_url('lightbox2', 'css')}"
            integrity="#{library_integrity('lightbox2', 'css')}"
            crossorigin="anonymous"
          >
        HTML
      end

      if images['photoswipe']
        output << <<~HTML
          <!-- PhotoSwipe -->
          <link
            rel="stylesheet"
            href="#{library_url('photoswipe', 'css')}"
            crossorigin="anonymous"
          >
        HTML
      end

      if images['slider']
        output << <<~HTML
          <!-- Image slider -->
          <link
            rel="stylesheet"
            href="#{library_url('swiper', 'css')}"
            integrity="#{library_integrity('swiper', 'css')}"
            crossorigin="anonymous"
          >
        HTML
      end

      if images['spotlight']
        output << <<~HTML
          <!-- Spotlight -->
          <link
            rel="stylesheet"
            href="#{library_url('spotlight', 'css')}"
            integrity="#{library_integrity('spotlight', 'css')}"
            crossorigin="anonymous"
          >
        HTML
      end

      if images['venobox']
        output << <<~HTML
          <!-- Venobox -->
          <link
            rel="stylesheet"
            href="#{library_url('venobox', 'css')}"
            integrity="#{library_integrity('venobox', 'css')}"
            crossorigin="anonymous"
          >
        HTML
      end

      output.join("\n")
    end
  end

  class ImageToolsScriptsTag < BaseImageToolsTag
    def render(context)
      images = page_images(context)
      output = []

      if medium_zoom_enabled?(context, images)
        output << <<~HTML
          <!-- Medium Zoom JS -->
          <script
            defer
            src="#{library_url('medium_zoom', 'js')}"
            integrity="#{library_integrity('medium_zoom', 'js')}"
            crossorigin="anonymous"
          ></script>
          <script defer src="#{asset_url(context, 'zoom.js')}"></script>
        HTML
      end

      if images['compare']
        output << <<~HTML
          <script
            defer
            src="#{library_url('img-comparison-slider', 'js')}"
            integrity="#{library_integrity('img-comparison-slider', 'js')}"
            crossorigin="anonymous"
          ></script>
        HTML
      end

      if lightbox_enabled?(images)
        output << <<~HTML
          <script
            defer
            src="#{library_url('lightbox2', 'js')}"
            integrity="#{library_integrity('lightbox2', 'js')}"
            crossorigin="anonymous"
          ></script>
        HTML
      end

      if images['photoswipe']
        output << <<~HTML
          <script type="module">
            import PhotoSwipeLightbox from "#{library_url('photoswipe-lightbox', 'js')}";
            import PhotoSwipe from "#{library_url('photoswipe', 'js')}";
            const photoswipe = new PhotoSwipeLightbox({
              gallery: ".pswp-gallery",
              children: "a",
              pswpModule: PhotoSwipe,
            });
            photoswipe.init();
          </script>
        HTML
      end

      if images['slider']
        output << <<~HTML
          <script
            defer
            src="#{library_url('swiper', 'js')}"
            integrity="#{library_integrity('swiper', 'js')}"
            crossorigin="anonymous"
          ></script>
        HTML
      end

      if images['spotlight']
        output << <<~HTML
          <script
            defer
            src="#{library_url('spotlight', 'js')}"
            crossorigin="anonymous"
          ></script>
        HTML
      end

      if images['venobox']
        output << <<~HTML
          <script
            defer
            src="#{library_url('venobox', 'js')}"
            integrity="#{library_integrity('venobox', 'js')}"
            crossorigin="anonymous"
          ></script>
          <script defer src="#{asset_url(context, 'venobox-setup.js')}"></script>
        HTML
      end

      output.join("\n")
    end
  end
end

Liquid::Template.register_tag('al_img_tools_styles', AlImgTools::ImageToolsStylesTag)
Liquid::Template.register_tag('al_img_tools_scripts', AlImgTools::ImageToolsScriptsTag)
