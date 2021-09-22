module TemperatureConverter exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { temperature : Celsius }


type Celsius
    = Celsius Float


type Fahrenheit
    = Fahrenheit Float


init : Model
init =
    { temperature = Celsius 0 }


type Msg
    = ChangeCelsius Celsius
    | ChangeFahrenheit Fahrenheit


update : Maybe Msg -> Model -> Model
update msg model =
    case msg of
        Just (ChangeCelsius c) ->
            { model | temperature = c }

        Just (ChangeFahrenheit f) ->
            { model | temperature = fahrenheitToCelsius f }

        Nothing ->
            model


view : Model -> Html (Maybe Msg)
view { temperature } =
    let
        (Celsius celsius) =
            temperature

        (Fahrenheit fahrenheit) =
            celciusToFahrenheit temperature
    in
    div []
        [ input
            [ type_ "number"
            , onInput (String.toFloat >> Maybe.map (Celsius >> ChangeCelsius))
            , value (String.fromFloat celsius)
            ]
            []
        , text " Celsius = "
        , input
            [ type_ "number"
            , onInput (String.toFloat >> Maybe.map (Fahrenheit >> ChangeFahrenheit))
            , value (String.fromFloat fahrenheit)
            ]
            []
        , text " Fahrenheit"
        ]


celciusToFahrenheit : Celsius -> Fahrenheit
celciusToFahrenheit (Celsius c) =
    Fahrenheit <| c * (9 / 5) + 32


fahrenheitToCelsius : Fahrenheit -> Celsius
fahrenheitToCelsius (Fahrenheit f) =
    Celsius <| (f - 32) * (5 / 9)
