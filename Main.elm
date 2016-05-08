import Html exposing (Html)
import List exposing (map, concatMap)
import Signal
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
    precincts : List (Int, Precinct.Model)}
    

type Action = Reset
    | Modify Int Precinct.Action


blankMap : Model
blankMap = {
    districts = map (\x -> {id = x}) [1,2,3,4,5],
    precincts = concatMap (\x -> map (\y -> 
        (100 * x + y, -- TODO
         Precinct.initSquare x y)) [0..5]) [0..3]}


update : Action -> Model -> Model
update action model = case action of
    Reset -> blankMap
    Modify id precinctAction ->
        let updatePrecinct (precinctID, precinctModel) = -- TODO: generalize
            if precinctID == id
               then (precinctID, Precinct.update precinctAction precinctModel)
               else (precinctID, precinctModel)
        in { model | precincts = List.map updatePrecinct model.precincts }


view : Signal.Address Action -> Model -> Html
view address model =
    svg [width "400", height "600"]
        (map (\(id, p) -> Precinct.view
            (Signal.forwardTo address (Modify id)) p) model.precincts)
