import Html
import Html.Attributes
import List exposing (map, concatMap, filter, length)
import Html.App
import Svg
import Svg.Attributes

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
    Html.div [] [
        Html.div [Html.Attributes.class "map-container"] [
            Svg.svg [Svg.Attributes.width "400", Svg.Attributes.height "600"]
                (map (\(id, p) -> Html.App.map (Modify id) (Precinct.view p)) model.precincts)],
        Html.div [Html.Attributes.class "data-container"]
            (map (\d -> Html.span [Html.Attributes.class "data-line"]
                                  [Html.text ("District " ++ toString d ++ ": " ++ toString (length (filter (\(id, p) -> p.district == Just d) model.precincts)))])
                 [1..5])]
