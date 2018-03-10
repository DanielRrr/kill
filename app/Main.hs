module Main where

import Lib (killProcess)
import Control.Concurrent (threadDelay)
import System.Process (runCommand)


main :: IO ()
main = do
  pr <- runCommand $ "./bracket-exe.exe"
  threadDelay 1000000
  killProcess pr
