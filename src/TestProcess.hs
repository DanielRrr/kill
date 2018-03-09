module Main where

import Control.Exception.Safe
import Control.Concurrent

main :: IO ()
main = bracket_
        (pure ())
        (threadDelay 1000 >> putStrLn "bla-bla-bla")
        (threadDelay 100500100500)
