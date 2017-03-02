Pod::Spec.new do |s|
  s.name          = "GZStackViewController"
  s.module_name   = "StackViewController"
  s.version       = "1.0.0"
  s.summary       = "Protocol powered approach of creating fully featured StackViewControllers in Swift3"
  s.homepage      = "https://github.com/genozhou/StackViewController"
  s.license       = "MIT"
  s.author        = { "Hanxuan Zhou (Geno)" => "genozhou@gmail.com" }
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/genozhou/StackViewController.git", :tag => s.version.to_s }
  s.source_files  = "StackViewController/**"
  s.frameworks    = "UIKit"
end
