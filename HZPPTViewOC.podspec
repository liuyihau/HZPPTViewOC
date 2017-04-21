
Pod::Spec.new do |s|
  s.name             = 'HZPPTViewOC'
  s.version          = '0.1.0'
  s.summary          = '花样的轮播器'

  s.description      = <<-DESC
                        简单实现图片轮播器的功能的一个控件，横向和竖线，以及单独文字的横向与竖向呈现
                       DESC

  s.homepage         = 'https://github.com/liuyihau/HZPPTViewOC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuyihua' => 'liuyihua2015@sina.com' }
  s.source           = { :git => 'https://github.com/liuyihau/HZPPTViewOC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HZPPTViewOC/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HZPPTViewOC' => ['HZPPTViewOC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
