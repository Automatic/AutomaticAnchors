# coding: utf-8
#

Pod::Spec.new do |s|

  s.name         = "AutomaticAnchors"
  s.version      = "0.0.1"
  s.summary      = "Automatic Anchors code"

  s.description  = <<-DESC
  This is Automatic Anchors code
                   DESC

  s.homepage     = "http://automatic.com"
  s.license      = "Proprietary, all rights reserved."

  s.author             = { "" => "" }
  s.platform     = :ios, "10.0"

  s.source       = { :git => "git@github.com:Automatic/AutomaticAnchors.git", :branch => "develop" }
  s.source_files  = "{source}/**/*.{swift}"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => 5 }

end
