Pod::Spec.new do |spec|
    spec.name         = "Trusdk"
    spec.version      = "0.0.3"
    spec.summary      = "SDK for tru.ID"
    spec.description  = <<-DESC
    iOS SDK for tru.id: Blazingly fast phone verification.
    Exposes APIs for instant, invisible strong authentication.
    DESC
    spec.homepage     = "https://tru.id/"
    spec.license      = { :type => "MIT", :file => "LICENSE.md" }
    spec.author             = { "author" => "eric@tru.id" }
    spec.documentation_url = "https://gitlab.com/tru-id/tru-sdk-ios/-/blob/master/README.md"
    spec.platforms = { :ios => "12.0" }
    spec.swift_version = "5.3"
    spec.source       = { :git => "https://gitlab.com/tru-id/tru-sdk-ios.git", :tag => "#{spec.version}" }
    spec.source_files  = "Sources/TruSDK/**/*.swift"
    spec.xcconfig = { "SWIFT_VERSION" => "5.3" }
end