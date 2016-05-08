module Precinct (Model, initSquare, Action, update, view) where

import Maybe exposing (Maybe(Just, Nothing))
import Svg exposing (..)
import Svg.Attributes exposing (..)


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


view : Model -> Svg
view precinct = rect [
    stroke "black",
    fill "none", -- TODO
    x (toString precinct.x),
    y (toString precinct.y),
    width (toString precinct.width),
    height (toString precinct.height)] []
