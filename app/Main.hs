module Main where

import System.Process
import Lib
import Control.Concurrent


main :: IO ()
main = do
  pr <- shellReturnHandle $ "./TestProcess"
  threadDelay 1000000
  kill <- killProcess pr
  return ()
