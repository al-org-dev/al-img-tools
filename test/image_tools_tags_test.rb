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
end
