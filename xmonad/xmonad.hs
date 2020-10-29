import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myLayout = gaps [(U, 10), (R, 10), (L, 10), (D, 10)] $ smartSpacing 10 $ (tiled ||| Mirror tiled ||| Full)
               where 
                   tiled = Tall nmaster delta ratio
                   nmaster = 1
                   ratio = 1/2
                   delta = 3/100

myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "tmp"),(xK_equal, "swap")]

myWorkspaces = ["1","2","3","4","5","6","7","8","9"] ++ (map snd myExtraWorkspaces)

myAdditionalKeys =
    [ ((mod1Mask, key), (windows $ W.greedyView ws))
      | (key,ws) <- myExtraWorkspaces
    ]
    ++
    [ ((mod1Mask .|. shiftMask, key), (windows $ W.shift ws))
      | (key,ws) <- myExtraWorkspaces
    ]

main = xmonad $ docks defaultConfig
    {
      workspaces = myWorkspaces,
      borderWidth = 2,
      focusedBorderColor = "#226fa5", 
      normalBorderColor = "#191919",
      startupHook = setWMName "LG3D",
      layoutHook = avoidStruts $ myLayout
    } `additionalKeys` (myAdditionalKeys)

