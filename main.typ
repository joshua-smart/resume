#set page(paper: "a4", margin: 0pt)
#set text(size: 12pt, font: "Liberation Sans")
#set par(justify: true)

#let entry(body) = stack(dir: ltr, spacing: 5pt,
  sym.circle,
  body
)

#let heading = {
  {
    set text(size: 16pt)
    heading(level: 1)[Joshua Smart]
  }
  {
    set text(size: 14pt)
    [Software Engineer]
  }
}

#let right-col = (it => {
  set line(length: 100%, stroke: 1pt + gray)
  it
})[
  == Contact

  - Devon, England
  - josh\@thesmarts.co.uk
  - (+44) 07745795528

  #line()

  == Skills

  -
  -

  #line()

  == Languages

  - C\#
  - Rust
  - JavaScript
  - Java

  #line()

  == Other

  - Netcraft award
]

#let main-content = [
  == Experience

  #entry()[
    === Director / Contractor, JSmart Software Development Ltd
    Devon, England #sym.bullet Self-Employed, Mar 2023 -- Present
  ]
  #entry()[
    === Junior Software Developer, Beran Instruments Ltd
    Devon, England #sym.bullet Full-time, Jul 2022 -- Sep 2022
  ]

  == Education

  #entry()[
    === University of Southampton, MEng Software Engineering
    Southampton, England #sym.bullet 2022 - 2026
  ]
]


#grid(
  columns: (5fr, 2fr),
  rows: auto,
  pad(left: 1cm, top: 1cm,
    stack(
      dir: ttb,
      spacing: 30pt,
      heading,
      main-content,
    )
  ),
  rect(
    width: 100%,
    height: 100%,
    stroke: none,
    fill: luma(235),
    pad(top: 1cm, x: 10pt, right-col),
  )
)
