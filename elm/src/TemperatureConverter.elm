module TemperatureConverter exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { temperature : Temperature }


type alias Temperature =
    ( Float, Unit )


type Unit
    = Celsius
    | Fahrenheit


init : Model
init =
    { temperature = ( 0, Celsius ) }


type Msg
    = ChangeIntent Unit String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeIntent unit stringValue ->
            String.toFloat stringValue
                |> Maybe.map (\f -> convert unit ( f, unit ))
                |> Maybe.map (\t -> { model | temperature = t })
                |> Maybe.withDefault model


view : Model -> Html Msg
view { temperature } =
    div []
        [ viewTemperatureInput (convert Celsius temperature)
        , text " Celsius = "
        , viewTemperatureInput (convert Fahrenheit temperature)
        , text " Fahrenheit"
        ]


viewTemperatureInput : Temperature -> Html Msg
viewTemperatureInput ( t, unit ) =
    input
        [ type_ "number"
        , onInput (ChangeIntent unit)
        , value (String.fromFloat t)
        ]
        []


convert : Unit -> Temperature -> Temperature
convert u t =
    case ( t, u ) of
        ( ( c, Celsius ), Fahrenheit ) ->
            ( c * (9 / 5) + 32, Fahrenheit )

        ( ( f, Fahrenheit ), Celsius ) ->
            ( (f - 32) * (5 / 9), Celsius )

        _ ->
            t
