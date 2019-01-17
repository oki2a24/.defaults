#!/bin/bash
#
# Usage:
#   install.sh
#
# Description:
#   Mac の設定スクリプトを呼び出し、実行します。 
#
###########################################################################

set -eux

readonly TOOLS_DIR="$(cd "$(dirname "$0")" && pwd)"

bash "$TOOLS_DIR/defaults.sh"
