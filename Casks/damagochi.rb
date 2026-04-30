cask "damagochi" do
  version "2.3.3"
  sha256 "eaf8b94229d6f12938ce0660d0b0b89b1ef6000a03114e39194d14ee34c657b3"

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
