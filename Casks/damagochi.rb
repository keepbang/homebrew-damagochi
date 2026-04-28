cask "damagochi" do
  version "2.1.8"
  sha256 "fefef0b509ad88de800c1026f557483ea340574b55c058de28e6bbb50b0ddd28"

  url "https://github.com/keepbang/damagochi/releases/download/v#{version}/Damagochi.zip"
  name "Damagochi"
  desc "Claude Code 활동으로 성장하는 다마고치 메뉴바 앱"
  homepage "https://github.com/keepbang/damagochi"

  app "Damagochi/Damagochi.app"
  binary "Damagochi/damagochi"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "/Applications/Damagochi.app"],
                   sudo: false
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/damagochi"],
                   sudo: false
  end

  uninstall quit:   "com.damagochi.app",
            delete: "/usr/local/bin/damagochi"

  zap trash: [
    "~/Library/Application Support/Damagochi",
    "~/Library/Preferences/com.damagochi.app.plist",
  ]

  caveats <<~EOS
    앱을 실행하면 온보딩에서 Claude Code 훅이 자동으로 등록됩니다:
      open /Applications/Damagochi.app
  EOS
end
