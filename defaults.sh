#!/bin/bash
#
# Usage:
#   defaults.sh
#
# Description:
#   Mac の設定を行います。
#
###########################################################################

set -eux

readonly SCRIPT_DIR=$(cd $(dirname $0); pwd)

########## Dock
# すべての（デフォルトの）アプリアイコンをDockから消去する
defaults write com.apple.dock persistent-apps -array
# Dockを自動的に表示/非表示
defaults write com.apple.dock autohide -bool true
# 表示開始までの遅延をゼロに設定
defaults write com.apple.dock autohide-delay -float 0
# Dock表示完了までの時間をゼロに設定
defaults write com.apple.dock autohide-time-modifier -float 0



########## FINDER
# show litsview as default
defaults write com.apple.Finder FXPreferredViewStyle -string "Nlsv"
# デフォルトで隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true
# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true



########## セキュリティとプライバシー
# ファイアーウォールをオンにする
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1



########## 日付と時刻
# メニューバーに日付、曜日、24時間、秒数を表示）
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'
# デジタルで表示
defaults write com.apple.menuextra.clock IsAnalog -bool false



########## ディスプレイ
# Night Shift を日の入りから日の出まで
# sudo defaults write /private/var/root/Library/Preferences/com.apple.CoreBrightness.plist BlueReductionEnabled -bool true
# sudo defaults write /private/var/root/Library/Preferences/com.apple.CoreBrightness.plist BlueReductionMode -bool true
# ↑ではダメだった。
# 次などを参考にスクリプトを組む方が良さそう。
# https://github.com/LukeChannings/.config/blob/master/install.macos#L418-L438
# http://koze.hatenablog.jp/entry/2018/07/06/110000



########## 省エネルギー
# 割合 (%) を表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"



########## キーボード
# 英字入力中にスペルを自動変換しない
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
# スマート引用符とスマートダッシュを使用
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false



########## ソフトウェアアップデート
# 自動更新チェックを有効にする
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# 毎日アプリケーションのアップデートを確認する
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# アプリケーションのアップデートをバックグラウンドでダウンロードする
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# システムデータファイルとセキュリティ更新プログラムをインストールする
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
# アプリケーションの自動更新を有効化
defaults write com.apple.commerce AutoUpdate -bool true



########## ターミナル
# カスタムテーマを使う、そのテーマをデフォルトに設定する
# https://github.com/djmonta/dotfiles/blob/8e9f972863000b0ef909931dd2d2bd18d45259d3/etc/init/osx/50-osx_settings.sh#L135-L145
readonly TERM_PROFILE='Iceberg';
readonly TERM_PATH='/terminal.app_colors/';
readonly CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
if [[ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]]; then
  open "${SCRIPT_DIR}${TERM_PATH}${TERM_PROFILE}.terminal"
  defaults write com.apple.Terminal "Default Window Settings" -string "${TERM_PROFILE}"
  defaults write com.apple.Terminal "Startup Window Settings" -string "${TERM_PROFILE}"
fi
defaults import com.apple.Terminal "$HOME/Library/Preferences/com.apple.Terminal.plist"



########## 反映
# Dock
killall Dock
# Finder
killall Finder
# メニューバー
killall SystemUIServer
# システム環境設定
killall System\ Preferences
