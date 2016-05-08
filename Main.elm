import Html exposing (Html)
import List exposing (map, concatMap)
import StartApp.Simple exposing (start)
import Svg exposing (..)
import Svg.Attributes exposing (..)

import Precinct

main : Signal Html
main = start { model = blankMap, update = update, view = view }

type alias District = {
    id: Int}


type alias Model = {
    districts : List District,
    precincts : List Precinct.Model}
    

type Action = Reset -- TODO


blankMap : Model
blankMap = {
    districts = map (\x -> {id = x}) [1,2,3,4,5],
    precincts = concatMap (\x -> map (\y -> 
        Precinct.initSquare x y) [0..5]) [0..3]}


update : Action -> Model -> Model
update action model = case action of
    Reset -> blankMap


view : Signal.Address Action -> Model -> Html
view address model =
    svg [width "400", height "600"]
        (map Precinct.view model.precincts)
