import Html
import List exposing (map, concatMap)
import Html.App
import Svg exposing (..)
import Svg.Attributes exposing (..)

import Precinct

main : Program Never
main = Html.App.beginnerProgram {
    model = blankMap,
    update = update,
    view = view}

type alias District = {
    id: Int}


type alias Model = {
    districts : List District,
    precincts : List (Int, Precinct.Model)}
    

type Msg = Reset
    | Modify Int Precinct.Msg


blankMap : Model
blankMap = {
    districts = map (\x -> {id = x}) [1,2,3,4,5],
    precincts = concatMap (\x -> map (\y -> 
        (100 * x + y, -- TODO
         Precinct.initSquare x y)) [0..5]) [0..3]}


update : Msg -> Model -> Model
update action model = case action of
    Reset -> blankMap
    Modify id precinctMsg ->
        let updatePrecinct (precinctID, precinctModel) = -- TODO: generalize
            if precinctID == id
               then (precinctID, Precinct.update precinctMsg precinctModel)
               else (precinctID, precinctModel)
        in { model | precincts = List.map updatePrecinct model.precincts }


view : Model -> Html.Html Msg
view model =
    svg [width "400", height "600"]
        (map (\(id, p) -> Html.App.map (Modify id) (Precinct.view p)) model.precincts)
