Pod::Spec.new do |spec|

   spec.name          = "SGExtensionsUtilities"

  spec.version        = "0.0.1"

  spec.summary        = "Extensions & Utilities"

  spec.description    = "Library to provide swift extensions & utilites"

  spec.homepage       = "https://github.com/sanjeevworkstation/SGExtensionsUtilities"

  spec.license        = { :type => "MIT", :file => "LICENSE" }

  spec.author         = { "Sanjeev Gautam" => "sanjeevworkstation@gmail.com" }

  spec.platform       = :ios, "9.0"
  spec.swift_version  = '4.2'

  spec.source         = { :git => "https://github.com/sanjeevworkstation/SGExtensionsUtilities.git", :tag => '0.0.1' }

  spec.source_files   = "SGExtensionsUtilities/SGExtensionsUtilities/**/*.{swift}"

end