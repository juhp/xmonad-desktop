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
     case (length args) of
          1 | (head args) `elem` desktops -> desktop (head args)
          0 -> do
               session <- getEnv "DESKTOP_SESSION"
               if (map toLower session) `elem` desktops
                  then desktop (map toLower session)
                  else desktop "desktop"
          otherwise -> help

help = putStrLn "Usage: xmonad-desktop [desktop|gnome|kde|xfce]"

desktop :: String -> IO ()
desktop "desktop" = xmonad desktopConfig
desktop "gnome" = xmonad gnomeConfig
desktop "kde" = xmonad kde4Config
desktop "xfce" = xmonad xfceConfig
