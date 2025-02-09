Gem::Specification.new do |spec|
  spec.name          = "al_img_tools"
  spec.version       = "0.1.0"
  spec.authors       = ["al-org"]
  spec.email         = ["dev@al-org.com"]
  spec.summary       = "al-folio plugin for image manipulation features"
  spec.description   = "al-folio plugin that provides various image manipulation features like zoom, gallery, comparison, and more"
  spec.homepage      = "https://github.com/al-org-dev/al-img-tools"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 3.0"
  spec.add_dependency "jekyll-3rd-party-libraries"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
end