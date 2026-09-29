// COVER SHEET
#page(numbering: none)[
  #align(center + horizon)[
    #text(size: 24pt, weight: "bold")[PwC UK Office Attendance Predictor]
    #v(0.5em)
    #text(size: 14pt)[Project Proposal]

    #v(3em)
    #grid(
      columns: (auto, auto),
      column-gutter: 1em,
      row-gutter: 0.8em,
      align: (right, left),
      [*Name:*], [Emmanuel Phillips],
      [*Student ID:*], [230355585],
      [*Module:*], [IOT6002U - Assessment 001],
      [*University email:*], [ec23279\@qmul.ac.uk],
      [*Work email:*], [emmanuel.j.phillips\@pwc.com],
    )
  ]
  #align(center + bottom)[
    #datetime.today().display("[day] [month repr:long] [year]")
  ]
]

// SET UP LAYOUT FOR REST OF THE DOCUMENT
#set page(numbering: "1")
#set heading(numbering: "1.")
#set text(size: 11pt, font: "New Computer Modern")

//SET UP CONTENTS PAGE
#outline()
#pagebreak() // ENSURE CONTENTS IS ON ITS OWN PAGE

// 150 WORDS
= Problem Definition

// 100 WORDS
= Project Aim and Objectives

// 150 WORDS
= Research Plan

// 100 WORDS
= Identification of Technologies, Tools and/or Datasets

// EXCLUDED FROM WORD COUNT
= Project Plan and Milestones

// EXCLUDED FROM WORD COUNT
= Risk Register

// EXCLUDED FROM WORD COUNT
= References

// EXCLUDED FROM WORD COUNT
= Appendices
