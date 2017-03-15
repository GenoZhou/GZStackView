Pod::Spec.new do |s|
  s.name          = "GZStackView"
  s.module_name   = "GZStackView"
  s.version       = "1.0.4"
  s.summary       = "Protocol oriented approach of creating fully featured StackViewController in Swift3"
  s.description      = <<-DESC
UIKit has UITableViewController for UITableView, as well as having UICollectionViewController for UICollectionView.
So why not having a UIStackViewController for UIStackView?
			DESC
  s.homepage      = "https://github.com/genozhou/GZStackView"
  s.license       = "MIT"
  s.author        = { "Hanxuan Zhou (Geno)" => "genozhou@gmail.com" }
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/genozhou/GZStackView.git", :tag => s.version.to_s }
  s.source_files  = "GZStackView/**"
  s.frameworks    = "UIKit"
end
