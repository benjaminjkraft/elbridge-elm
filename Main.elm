import Html exposing (Html)
import List exposing (map, concatMap)
import Maybe exposing (Maybe(Just, Nothing))
import StartApp.Simple exposing (start)
import Svg exposing (..)
import Svg.Attributes exposing (..)

main : Signal Html
main = start { model = blankMap, update = update, view = view }

type alias District = {
    id: Int}

type alias Precinct = {
    x : Int,
    y : Int,
    width : Int,
    height : Int,
    pop : Int,
    district : Maybe Int}


type alias Model = {
    districts : List District,
    precincts : List Precinct}
    

type Action = Reset -- TODO


blankMap : Model
blankMap = {
    districts = map (\x -> {id = x}) [1,2,3,4,5],
    precincts = concatMap (\x -> map (\y -> {
        x = 100 * x, y = 100 * y,
        width = 100, height = 100,
        pop = 1, district = Nothing}
    ) [0..5]) [0..3]}


update : Action -> Model -> Model
update action model = case action of
    Reset -> blankMap


view : Signal.Address Action -> Model -> Html
view address model =
    svg [width "400", height "600"]
        (map viewPrecinct model.precincts)

viewPrecinct : Precinct -> Svg
viewPrecinct precinct = rect [
    stroke "black",
    fill "none", -- TODO
    x (toString precinct.x),
    y (toString precinct.y),
    width (toString precinct.width),
    height (toString precinct.height)] []
