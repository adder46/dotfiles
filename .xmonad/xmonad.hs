import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)
import qualified XMonad.StackSet as W

myLayout = gaps [(U, 10), (R, 10), (L, 10), (D, 10)] $ spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $
             layoutHook def

myExtraWorkspaces = [(xK_0, "10"), (xK_minus, "11"), (xK_equal, "12")]

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]

clickable' :: WorkspaceId -> String
clickable' w = xmobarAction ("xmonadctl view\\\"" ++ w ++ "\\\"") "1" w

myAdditionalKeys =
    [ ((mod1Mask, key), windows $ W.greedyView ws)
      | (key, ws) <- myExtraWorkspaces
    ]
    ++
    [ ((mod1Mask .|. shiftMask, key), windows $ W.shift ws)
      | (key, ws) <- myExtraWorkspaces
    ]
    ++
    [
      ((mod1Mask, xK_F2), spawn "thunar")
    , ((mod1Mask, xK_F3), spawn "firefox")
    , ((mod1Mask, xK_F4), spawn "code")
    , ((mod1Mask, xK_F5), spawn "thunderbird")
    , ((mod1Mask, xK_Escape), spawn "xfce4-appfinder")
    , ((mod4Mask, xK_Print), spawn "xfce4-screenshooter")
    , ((mod4Mask, xK_KP_Add), spawn "amixer -D pulse sset Master 5%+")
    , ((mod4Mask, xK_KP_Subtract), spawn "amixer -D pulse sset Master 5%-")
    , ((mod1Mask .|. controlMask, xK_p), spawn "passmenu") 
    , ((mod1Mask .|. controlMask, xK_c), spawn "clipmenu")
    , ((mod1Mask .|. controlMask, xK_m), spawn "mailwatch_restart")
    , ((mod1Mask .|. controlMask, xK_x), spawn "xfce4-panel -r")
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks def
        {
          workspaces = myWorkspaces
          , borderWidth = 2
          , focusedBorderColor = "#226fa5"
          , normalBorderColor = "#191919"
          , handleEventHook = serverModeEventHookCmd
                            <+> serverModeEventHook
                            <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
          , layoutHook = avoidStruts myLayout
          , logHook = dynamicLogWithPP $ def
            { ppOutput = hPutStrLn xmproc
            , ppCurrent = xmobarColor "blue" "" . wrap "[" "]"
            , ppHiddenNoWindows = xmobarColor "grey" "" . clickable'
            , ppVisible = wrap "(" ")"
            , ppUrgent  = xmobarColor "red" "yellow"
            , ppOrder = \(ws:_:_:_) -> [pad ws]
            , ppHidden = clickable'
            }
          , startupHook = setWMName "LG3D"
          , manageHook = manageDocks
        } `additionalKeys` myAdditionalKeys

