# Al-Img-Tools

A Jekyll plugin that provides various image manipulation features for al-folio sites.

## Features

- Image comparison sliders
- Lightbox galleries
- Medium zoom
- Image sliders
- PhotoSwipe galleries
- VenoBox galleries

## Installation

Add this line to your Jekyll site's Gemfile:

```ruby
gem 'al_img_tools'
```

And then execute:

```bash
$ bundle install
```

## Usage

1. Add the plugin to your site's `_config.yml`:

```yaml
plugins:
  - al_img_tools
```

2. Use image features in your pages:

```yaml
---
layout: page
title: Gallery
images:
  gallery: true      # Enable lightbox gallery
  compare: true      # Enable image comparison slider
  slider: true       # Enable image slider
  photoswipe: true   # Enable PhotoSwipe gallery
  venobox: true      # Enable VenoBox gallery
  medium_zoom: true  # Enable medium zoom for images
---
```

3. Add the image scripts tag to your layout file (e.g., `_layouts/default.html`):

```liquid
{% al_img_scripts %}
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub.