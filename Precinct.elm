module Precinct (Model, initSquare, Action, update, view) where

import Debug exposing (crash)
import Maybe exposing (Maybe(Just, Nothing))
import Signal
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


type alias Model = {
    x : Int,
    y : Int,
    width : Int,
    height : Int,
    pop : Int,
    district : Maybe Int}


initSquare : Int -> Int -> Model
initSquare x y = {
    x = 100 * x, y = 100 * y,
    width = 100, height = 100,
    pop = 1, district = Nothing}


type alias Action = Maybe Int -- district ID to switch to


update : Action -> Model -> Model
update district precinct = {precinct | district = district}


view : Signal.Address Action -> Model -> Svg
view address precinct = rect [
    stroke "black",
    fill (precinctColor precinct.district),
    onClick (Signal.message address (nextColor precinct.district)),
    x (toString precinct.x),
    y (toString precinct.y),
    width (toString precinct.width),
    height (toString precinct.height)] []

nextColor : Maybe Int -> Maybe Int
nextColor district = case district of
    Nothing -> Just 1
    Just x -> if x < 5 then Just (x + 1) else Nothing -- TODO

precinctColor : Maybe Int -> String
precinctColor district = case district of
    Nothing -> "white"
    Just 1 -> "red"
    Just 2 -> "blue"
    Just 3 -> "green"
    Just 4 -> "yellow"
    Just 5 -> "purple"
    Just _ -> crash "unsupported district ID" -- TODO
