import Data.Char (toLower)
import System.Environment (getArgs, getEnv)

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce

desktops = ["desktop", "gnome", "kde", "xfce"]

main = do
     args <- getArgs
     case args of
          [arg] | arg `elem` desktops -> desktop arg
          [] -> do
               session <- getEnv "DESKTOP_SESSION"
               if map toLower session `elem` desktops
                  then desktop (map toLower session)
                  else desktop "desktop"
          _ -> help

help = putStrLn "Usage: xmonad-desktop [desktop|gnome|kde|xfce]"

desktop :: String -> IO ()
desktop s = putStrLn ("Starting xmonad configured for " ++ s) >> run_desktop s

run_desktop :: String -> IO ()
run_desktop "desktop" = xmonad desktopConfig
run_desktop "gnome" = xmonad gnomeConfig
run_desktop "kde" = xmonad kde4Config
run_desktop "xfce" = xmonad xfceConfig
