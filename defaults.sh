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
# ファイアーウォールを入りにする
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

########## 反映
# Finder
killall Finder
# メニューバー
killall SystemUIServer
# システム環境設定
killall System\ Preferences
