#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint azure_speech_recognition_services.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'azure_speech_recognition_services'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter integration for Microsoft Azure’s speech-to-text recognition service.'
  s.description      = <<-DESC
A Flutter integration for Microsoft Azure’s speech-to-text recognition service.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'MicrosoftCognitiveServicesSpeech-iOS', '1.48.2'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'azure_speech_recognition_services_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
