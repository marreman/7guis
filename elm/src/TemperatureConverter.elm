module TemperatureConverter exposing (main)

import Browser
import Html exposing (Html, div, input, pre, text)
import Html.Attributes exposing (attribute, type_, value)
import Html.Events exposing (onInput)
import Maybe.Extra


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    ( Maybe Temp, Maybe Temp )


type Temp
    = C String
    | F String


init : Model
init =
    ( Nothing, Nothing )


type Msg
    = Read Temp


update : Msg -> Model -> Model
update (Read temp) ( prevC, prevF ) =
    case temp of
        C v ->
            ( Just (C v), convert v toF |> Maybe.map F |> Maybe.Extra.orElse prevF )

        F v ->
            ( convert v toC |> Maybe.map C |> Maybe.Extra.orElse prevC, Just (F v) )


convert : String -> (Float -> Float) -> Maybe String
convert x fn =
    String.toFloat x |> Maybe.map (fn >> String.fromFloat)


view : Model -> Html Msg
view ( c, f ) =
    div []
        [ input_ c (C >> Read)
        , input_ f (F >> Read)
        , pre [] [ ( c, f ) |> Debug.toString |> text ]
        ]


input_ temp msg =
    let
        valThing =
            case temp of
                Just t ->
                    [ value (getValue t) ]

                Nothing ->
                    []
    in
    input (valThing ++ [ onInput msg ]) []


getValue temp =
    case temp of
        C v ->
            v

        F v ->
            v


toC f =
    (f - 32) * (5 / 9)


toF c =
    c * (9 / 5) + 32
