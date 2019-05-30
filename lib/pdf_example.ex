defmodule PdfExample do
  @blue "#267ad3"
  @foreground "#3c3c3c"

  def generate_pdf(items) do
    html =
      Sneeze.render([
        :html,
        [
          :body,
          %{
            style:
              style(%{
                "font-family" => "Helvetica",
                "font-size" => "20pt",
                "color" => @foreground,
              })
          },
          render_header(),
          render_list(items),

          render_bg()
        ]
      ])

    {:ok, filename} = PdfGenerator.generate(html, page_size: "A4", shell_params: ["--margin-left", "0", "--margin-right", "0", "--margin-top", "0"])

    File.rename(filename, "./shopping-list.pdf")
  end

  defp style(style_map) do
    style_map
    |> Enum.map(fn {key, value} ->
      "#{key}: #{value}"
    end)
    |> Enum.join(";")
  end


  defp render_bg() do

    [
     :div,
      %{
        style:
          style(%{
            "position" => "absolute",
            "left"     => "0",
            "top"      => "0",
            "width"    => "40%",
            "background-color" => "#f5f1e6",
            "height"   => "600px",
            "padding-left" => "30px",
            "padding-top"  => "30px"
          })
      },
      [
        [
          :h1,
          %{
            style:
              style(%{
                "font-size" => "35pt",
                "color" => "black",
                "margin-top" => "0pt",
                "padding-top" => "0pt"
              })
          },
          "Company"
        ],
        [
          :h2,
          %{
            style:
              style(%{
                "font-size" => "25px",
                "color" => "black",
                "margin-top" => "0px",
                "padding-top" => "0px"
              })
          },
          "Monthly statement"
        ],
        [
          :p,
          %{
            style:
              style(%{
                "font-size" => "18px",
                "color" => "black",
                "font-weight" => "bolder",
                "margin-top" => "30px",
                "line-height" => "1"
              })
          },
          "Dunger Mifflin"
        ],
        [
          :p,
          %{
            style:
              style(%{
                "font-size" => "18px",
                "color" => "black",
                "line-height" => "1"
              })
          },
          "Dwight Schrute"
        ],
        [
          :p,
          %{
            style:
              style(%{
                "font-size" => "18px",
                "color" => "black",
                "line-height" => "1"
              })
          },
          "Account ***** **** 1234"
        ],
        [
          :p,
          %{
            style:
              style(%{
                "font-size" => "18px",
                "color" => "black",
                "line-height" => "1"
              })
          },
          "Pay cycle: Manual once monthly"
        ],
      ]
    ]

  end

  defp render_header() do

    date = DateTime.utc_now()
    date_string = "#{date.year}/#{date.month}/#{date.day}"

    [
      :div,
      %{
        style:
          style(%{
            "display" => "flex",
            "flex-direction" => "column",
            "align-items" => "flex-start",
            "z-index"  => "2"
          })
      },
      [
        [
          :h1,
          %{
            style:
              style(%{
                "font-size" => "35pt",
                "color" => @blue,
                "margin-top" => "0pt",
                "padding-top" => "0pt"

              })
          },
          "Shopping List"
        ],
        [
          :h3,
          %{
            style:
              style(%{
                "font-size" => "20pt",
                "margin-top" => "-20pt"
              })
          },
          date_string
        ]
      ]
    ]
  end

  defp render_list(items) do
    list = [:ul, %{style: style(%{"list-style" => "none", "padding-left": "0"})}]
    list_items = Enum.map(items, &render_item/1)
    list ++ list_items
  end

  defp render_item(item) do
    [
      :li,
      [
        :span,
        %{
          style:
            style(%{
              "display" => "inline-block",
              "border" => "solid 2pt ",
              "width" => "10pt",
              "height" => "10pt",
              "border-radius" => "2pt",
              "margin-right" => "15pt"
            })
        }
      ],
      item,
      [:hr]
    ]
  end
end
