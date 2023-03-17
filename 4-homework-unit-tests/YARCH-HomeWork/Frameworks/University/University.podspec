Pod::Spec.new do |s|
  s.name         = 'University'
  s.summary      = 'University module of homework YARCH'
  s.version      = '1.0'
  s.authors      = { 'Ilya Golubev' => 'iagolubev@icloud.com' }
  s.license      = { :type => 'BSD' }
  s.homepage     = 'https://www.gitlab-alfa-campus.ru'
  s.source       = { :git => 'git@www.gitlab-alfa-campus.ru' }
  s.dependency 'SnapKit'

  s.subspec 'UniversityList' do |sp|
    sp.source_files = 'UniversityList/**/*.swift'
  end

end