require "aux.olua-cls"
require "conf.cocos2d.import-cocos2d-type"

local M = {}

M.NAME = "cocos2d_ui"
M.HEADER_PATH = "template/frameworks/libxgame/src/xgame/lua-bindings/lua_cocos2d_ui.h"
M.SOURCE_PATH = "template/frameworks/libxgame/src/xgame/lua-bindings/lua_cocos2d_ui.cpp"

M.INCLUDES = [[
#include "xgame/lua-bindings/lua_cocos2d_ui.h"
#include "xgame/lua-bindings/lua_conv.h"
#include "xgame/lua-bindings/lua_conv_manual.h"
#include "xgame/xlua.h"
#include "xgame/xruntime.h"
#include "olua/olua.hpp"
#include "cocos2d.h"
#include "ui/CocosGUI.h"
]]

M.STATIC_CHUNK = [[
]]

M.CLASSES = {
    include("conf/cocos2d/ui/base/ccui.Widget.lua"),
    include("conf/cocos2d/ui/base/ccui.Helper.lua"),
    include("conf/cocos2d/ui/base/ccui.Scale9Sprite.lua"),
    include("conf/cocos2d/ui/base/ccui.LayoutComponent.lua"),
    include("conf/cocos2d/ui/layout/ccui.LayoutParameter.lua"),
    include("conf/cocos2d/ui/layout/ccui.Layout.lua"),
    include("conf/cocos2d/ui/layout/ccui.HBox.lua"),
    include("conf/cocos2d/ui/layout/ccui.VBox.lua"),
    include("conf/cocos2d/ui/layout/ccui.RelativeBox.lua"),
    include("conf/cocos2d/ui/experimental/ccui.WebView.lua"),
    include("conf/cocos2d/ui/experimental/ccui.VideoPlayer.lua"),
}

return M