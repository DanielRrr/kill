module Main where

import ProcessKiller (stopProcess)
import Control.Concurrent (threadDelay)
import System.Process (runCommand)


main :: IO ()
main = do
  pr <- runCommand $ "./bracket-exe.exe"
  threadDelay 1000000
  stopProcess pr
