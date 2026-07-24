require 'minitest/autorun'
require 'liquid'

require_relative '../lib/al_img_tools'

class AlImgToolsTagsTest < Minitest::Test
  FakeSite = Struct.new(:static_files)

  def render_styles(site:, page:)
    template = Liquid::Template.parse('{% al_img_tools_styles %}')
    template.render({ 'site' => site }, registers: { page: page })
  end

  def render_scripts(site:, page:)
    template = Liquid::Template.parse('{% al_img_tools_scripts %}')
    template.render({ 'site' => site }, registers: { page: page })
  end

  def test_renders_requested_styles
    output = render_styles(
      site: { 'baseurl' => '/base' },
      page: { 'images' => { 'compare' => true, 'gallery' => true, 'venobox' => true } }
    )

    assert_includes output, 'img-comparison-slider'
    assert_includes output, '/base/assets/al_img_tools/css/lightbox2-adapter.css'
    assert_includes output, 'venobox'
  end

  def test_renders_requested_scripts_with_baseurl
    output = render_scripts(
      site: { 'baseurl' => '/base', 'enable_medium_zoom' => true },
      page: { 'images' => { 'venobox' => true, 'lightbox2' => true } }
    )

    assert_includes output, 'medium-zoom'
    assert_includes output, '/base/assets/al_img_tools/js/zoom.js'
    assert_includes output, '/base/assets/al_img_tools/js/venobox-setup.js'
    assert_includes output, '/base/assets/al_img_tools/js/lightbox2-adapter.js'
  end

  def test_returns_empty_output_when_no_image_features_enabled
    output = render_scripts(
      site: { 'baseurl' => '/base' },
      page: { 'images' => {} }
    )

    assert_equal '', output
  end

  def test_assets_generator_registers_plugin_files
    site = FakeSite.new([])

    AlImgTools::AssetsGenerator.new.generate(site)

    names = site.static_files.map(&:name)
    assert_includes names, 'zoom.js'
    assert_includes names, 'venobox-setup.js'
    assert_includes names, 'lightbox2-adapter.js'
    assert_includes names, 'lightbox2-adapter.css'
  end

  def test_slider_pins_patched_swiper_with_matching_integrity
    styles = render_styles(
      site: { 'baseurl' => '' },
      page: { 'images' => { 'slider' => true } }
    )
    scripts = render_scripts(
      site: { 'baseurl' => '' },
      page: { 'images' => { 'slider' => true } }
    )

    # Security pin: Swiper must stay >= 12.1.2 to avoid the prototype-pollution
    # vulnerability CVE-2026-27212 (affects >= 6.5.1, < 12.1.2). The SRI hashes
    # below must match the exact bytes served for swiper@12.1.2.
    assert_includes scripts, 'swiper@12.1.2/swiper-element-bundle.min.js'
    assert_includes scripts, 'sha256-J5Bi68Hj65rj5tUW3iI6qEJFxBuP5ncTmqL1+3NFqO0='
    assert_includes styles, 'swiper@12.1.2/swiper-bundle.min.css'
    assert_includes styles, 'sha256-luxVrnBnR9z2CvS7noxOPcUPX9nt8w0l4LscODUm5/k='
    refute_includes scripts, 'swiper@11.0.5'
    refute_includes styles, 'swiper@11.0.5'
  end
end
