import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Maybe

myLayout = gaps [(U, 10), (R, 10), (L, 10), (D, 10)] $ smartSpacing 10 $ (tiled ||| Mirror tiled ||| Full)
               where 
                   tiled = Tall nmaster delta ratio
                   nmaster = 1
                   ratio = 1/2
                   delta = 3/100

myExtraWorkspaces = [(xK_0, "0"), (xK_minus, "minus"), (xK_equal, "equal")]

xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"]
    where
        clickable l = [ "<action=xdotool key alt+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                             (i, ws) <- zip ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"] l,
                             let n = i ]

myAdditionalKeys =
    [ ((mod1Mask, key), (windows $ W.greedyView ws))
      | (key, ws) <- myExtraWorkspaces
    ]
    ++
    [ ((mod1Mask .|. shiftMask, key), (windows $ W.shift ws))
      | (key, ws) <- myExtraWorkspaces
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks defaultConfig
        {
          workspaces = myWorkspaces,
          borderWidth = 2,
          focusedBorderColor = "#226fa5", 
          normalBorderColor = "#191919",
          layoutHook = avoidStruts $ myLayout,
          logHook = dynamicLogWithPP $ def
			{ ppOutput = hPutStrLn xmproc
			, ppCurrent = xmobarColor "blue" "" . wrap "[" "]"
			, ppHiddenNoWindows = xmobarColor "grey" ""
			, ppVisible = wrap "(" ")"
			, ppUrgent  = xmobarColor "red" "yellow"
            , ppOrder = \(ws:_:_:_) -> [pad ws]
			},
          startupHook = setWMName "LG3D",
          manageHook = manageDocks
        } `additionalKeys` (myAdditionalKeys)

