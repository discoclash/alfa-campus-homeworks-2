Pod::Spec.new do |s|
  s.name         = 'CustomFrameworks'
  s.version      = '1.0'
  s.license      = { :type => 'BSD' }
  s.homepage     = 'https://www.gitlab-alfa-campus.ru'
  s.authors      = { 'Ilya Golubev' => 'iagolubev@icloud.com' }
  s.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  s.source       = { :git => 'git@www.gitlab-alfa-campus.ru:iagolubev/homework-cocoapods.git' }

  s.subspec 'ViewControllers' do |sp|
    sp.source_files = 'Sources/**/*ViewController.swift'
  end

  s.subspec 'Views' do |sp|
    sp.source_files = 'Sources/**/*View.swift'
  end
end