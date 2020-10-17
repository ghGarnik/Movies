# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '13.0'

target 'Movies' do
  use_frameworks!

  pod 'Kingfisher', '~> 5.0'
  pod 'RxAlamofire', '~> 5.6.2'
  pod 'RxCocoa', '~> 5.1.1'
  pod 'RxSwift', '~> 5.1.1'

  target 'MoviesTests' do
    inherit! :search_paths

  end

end

plugin 'cocoapods-keys', {
  :project => "Movies",
  :keys => [
    "apiKey"
  ]}
