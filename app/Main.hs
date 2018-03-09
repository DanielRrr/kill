module Main where

import Lib
import Control.Concurrent (threadDelay)


main :: IO ()
main = do
  pr <- shellReturnHandle $ "./TestProcess"
  threadDelay 1000000
  kill <- killProcess pr
  return ()
