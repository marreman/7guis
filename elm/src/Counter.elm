module Counter exposing (main)

import Browser
import Html exposing (Html)
import Html.Events


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { count : Int }


init : Model
init =
    { count = 0 }


type Msg
    = Count


update : Msg -> Model -> Model
update msg model =
    case msg of
        Count ->
            { model | count = model.count + 1 }


view : Model -> Html Msg
view { count } =
    Html.div []
        [ Html.text (String.fromInt count)
        , Html.button [ Html.Events.onClick Count ] [ Html.text "Count" ]
        ]
