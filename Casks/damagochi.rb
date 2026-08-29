cask "damagochi" do
  version "2.8.0"
  sha256 "be9fec87b5165bd715e23afc435b518bc9e49ef1a8493751f6365103b3a02f98"

  url "https://github.com/keepbang/damagochi/releases/download/v#{version}/Damagochi.zip"
  name "Damagochi"
  desc "Claude Code 또는 Codex 활동으로 성장하는 다마고치 메뉴바 앱"
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
    앱을 실행하면 온보딩에서 Claude Code와 Codex 훅을 등록할 수 있습니다:
      open /Applications/Damagochi.app
  EOS
end
