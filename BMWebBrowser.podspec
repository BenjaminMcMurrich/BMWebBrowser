Pod::Spec.new do |s|
  s.name        = 'BMWebBrowser'
  s.version     = '0.1'
  s.authors     = { 'Benjamin McMurrich' => 'benjamin@digidust.com' }
  s.homepage    = 'https://github.com/BenjaminMcMurrich/BMWebBrowser'
  s.summary     = 'Embedded Web Browser like in the Twitter and Facebook apps'
  s.source      = { :git => 'https://github.com/BenjaminMcMurrich/BMWebBrowser.git',
                    :tag => '0.1' }
                    
  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'BMWebBrowser'
  s.public_header_files = 'BMWebBrowser/*.h'
  s.resources = "BMWebBrowser/assets/*.png"

  s.ios.deployment_target = '7.0'
end