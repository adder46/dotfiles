
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import Data.Ord
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Util.WorkspaceCompare
import Debug.Trace(trace)


myLayout = gaps [(U, 10), (R, 10), (L, 10), (D, 10)] $ spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $
             layoutHook def

myWorkspaces = 
  [ (xK_1, "1")
  , (xK_2, "2")
  , (xK_3, "3")
  , (xK_4, "4")
  , (xK_5, "5")
  , (xK_6, "6")
  , (xK_7, "7")
  , (xK_8, "8")
  , (xK_9, "9")
  , (xK_0, "10")
  , (xK_minus, "11")
  , (xK_equal, "12")
  ]


myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, key), windows $ onCurrentScreen W.greedyView ws)
      | (key, ws) <- myWorkspaces
    ]
    ++
    [ ((modMask .|. shiftMask, key), windows $ onCurrentScreen W.shift ws)
      | (key, ws) <- myWorkspaces
    ]
    ++
    [
    -- Spawn the terminal
      ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    
    -- Spawn dmenu
    , ((modMask, xK_p), spawn "dmenu_run")

    -- Close focused window 
    , ((modMask .|. shiftMask, xK_c), kill)
 
     -- Rotate through the available layout algorithms
    , ((modMask, xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modMask, xK_n), refresh)
 
    -- Move focus to the next window
    , ((modMask, xK_Tab), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modMask, xK_j), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modMask, xK_k), windows W.focusUp)
 
    -- Move focus to the master window
    , ((modMask, xK_m), windows W.focusMaster)
 
    -- Swap the focused window and the master window
    , ((modMask, xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
 
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
 
    -- Shrink the master area
    , ((modMask, xK_h), sendMessage Shrink)
 
    -- Expand the master area
    , ((modMask, xK_l), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modMask, xK_t), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modMask, xK_comma), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap
    , ((modMask, xK_b), sendMessage ToggleStruts)
 
    -- Restart xmonad
    , ((modMask,  xK_q), broadcastMessage ReleaseResources >> restart "xmonad" True)
    ]

myAdditionalKeysP =
    [
      ("M-<F2>", spawn "thunar")
    , ("M-<F3>", spawn "firefox")
    , ("M-<F4>", spawn "code")
    , ("M-<F5>", spawn "thunderbird")
    , ("M-<Escape>", spawn "xfce4-appfinder")
    , ("M4-<Print>", spawn "xfce4-screenshooter")
    , ("M4-<KP_Add>", spawn "amixer -D pulse sset Master 5%+")
    , ("M4-<KP_Subtract>", spawn "amixer -D pulse sset Master 5%-")
    , ("M-C-p", spawn "passmenu") 
    , ("M-C-c", spawn "clipmenu")
    , ("M-C-m", spawn "mailwatch_restart")
    , ("M-C-x", spawn "xfce4-panel -r")
    , ("M-C-<Left>", spawn "playerctl previous")
    , ("M-C-<Right>", spawn "playerctl next")
    , ("M-C-<Space>", spawn "playerctl play-pause")
    ]

unScreen :: ScreenId -> Int ; unScreen (S n) = n

clickable' :: ScreenId -> WorkspaceId -> String
clickable' s w =  xmobarAction ("xmonadctl view\\\"" ++ show (unScreen s) ++ "_" ++ w ++ "\\\"") "1" w
compareNumbers = comparing (read :: String -> Int)

pp h s = marshallPP s def 
    { ppOutput = hPutStrLn h
    , ppCurrent = xmobarColor "blue" "" . wrap "[" "]"
    , ppHiddenNoWindows = xmobarColor "grey" "" . clickable' s
    , ppVisible = wrap "(" ")"
    , ppUrgent  = xmobarColor "red" "yellow"
    , ppOrder = \(ws:_:_:_) -> [pad ws]
    , ppHidden = clickable' s
    , ppSort = mkWsSort $ return compareNumbers
    }

main = do
    xmprocs <- mapM (\i -> spawnPipe $ "xmobar ~/.config/xmobar/xmobarrc-" ++ show i ++ " -x" ++ show i) [0..1]
    xmonad $ docks def
        {
          workspaces = withScreens 2 (map show [1..12])
          , keys = myKeys
          , borderWidth = 2
          , focusedBorderColor = "#226fa5"
          , normalBorderColor = "#191919"
          , handleEventHook = serverModeEventHookCmd
                            <+> serverModeEventHook
                            <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
          , layoutHook = avoidStruts myLayout
          , logHook = mapM_ dynamicLogWithPP $ zipWith pp xmprocs [0..1]
          , startupHook = setWMName "LG3D"
          , manageHook = manageDocks
        } `additionalKeysP` myAdditionalKeysP