# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'ChatApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ChatApp
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
pod 'Firebase/Analytics'
pod 'Firebase/Messaging'
pod 'FirebaseFirestoreSwift'

pod 'Gallery'
pod 'RealmSwift'

pod 'ProgressHUD'
pod 'SKPhotoBrowser'

pod 'MessageKit'
pod 'InputBarAccessoryView'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

end
