#import "math.typ": *

#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot
#import "@preview/equate:0.3.0": equate

#let font = (
  tiny:	        5pt,
  scriptsize:   7pt,
  footnotesize: 8pt,
  small:        9pt,
  normalsize:   10pt,
  large:        12pt,
  Large:        14pt,
  LARGE:        17pt,
  huge:         20pt,
  Huge:         25pt,
)

// Lifted from neurips2023.typ
#let make_figure_caption(it) = {
  set align(center)
  block({
    set align(left)
    set text(size: font.normalsize)
    it.supplement
    context {
      if it.numbering != none {
        [ ]
        it.counter.display(it.numbering)
      }
    }
    it.separator
    [ ]
    it.body
  })
}

// Lifted from neurips2023.typ
#let make_figure(caption_above: false, it) = {
  let body = block(width: 100%, {
    set align(center)
    set text(size: font.normalsize)
    if caption_above {
      v(1em, weak: true)  // Does not work at the block beginning.
      it.caption
    }
    v(1em, weak: true)
    it.body
    v(8pt, weak: true)    // Original 1em.
    if not caption_above {
      it.caption
      v(1em, weak: true)  // Does not work at the block ending.
    }
  })

  if it.placement == none {
    return body
  } else {
    return place(it.placement, body, float: true, clearance: 2.3em)
  }
}

#let report(
  title: [],
  authors: (),
  date: auto,
  abstract: none,
  bibliography: none,
  bibliography-opts: (:),
  body,
) = {
  // Document metadata
  set document(
    title: title,
    date: date,
    author: authors.map(author => author.name)
  )

  // The body font
  set text(font: "New Computer Modern", size: 10pt)

  
  // Tables and figures
  set figure.caption(separator: [:])
  show figure: set block(breakable: false)
  show figure.caption.where(kind: table): it => make_figure_caption(it)
  show figure.caption.where(kind: image): it => make_figure_caption(it)
  show figure.where(kind: image): it => make_figure(it)
  show figure.where(kind: table): it => make_figure(it, caption_above: true)

  // Code blocks
  set raw(tab-size: 8)
  show raw: set text(font: "JetBrains Mono")
  show raw.where(block: true): block.with(
    fill: luma(250),
    inset: 10pt,
    radius: 4pt,
    width: 100%
  )

  // Paper properties
  set page(
    paper: "a4",
    margin: 3cm,
    numbering: "1"
  )

  // Lists
  // Credit: https://github.com/flaribbit/numbly/blob/afb0386f063e18737bf8bdedeff51e33f0dd3f3a/README.md?plain=1#L18
  set enum(indent: 10pt, body-indent: 9pt, full: true,
           numbering: (..nums) => {
             let formats = ("1.", "(a)", "(i)")
             return numbering(formats.at(nums.pos().len() - 1),
                              nums.pos().last())
  })
  set list(indent: 10pt, body-indent: 9pt)

  // credit: https://forum.typst.app/t/how-to-make-nested-bulleted-lists-where-content-includes-centered-equations/846/3
  // show math.equation.where(block: true): eq => {
  //   block(width: 100%, inset: 0pt, align(center, eq))
  // }
  // show: equate.with(breakable: true, sub-numbering: true)
  // set math.equation(numbering: "(1.1)")

  // Headings
  set heading(numbering: "1.1.1")
  show heading: it => {
    let number = if it.numbering != none {
      context {
        counter(heading).display(it.numbering)
      }
    }
    if it.numbering != none {
      [#number#h(1em)#it.body]
    } else {
      [#it.body]
    }
  }

  
  // Links
  show link: set text(fill: rgb("#0a6ae0"))

  // Paragraph properties
  set par(leading: 0.55em, justify: true)

  // TODO: Add abstract
  //
  // FIXME: If authors.len() % 3 != 0, the last row should have
  // authors.len() % 3 != 3 columns.
  place(
    top,
    scope: "parent",
    float: true,
    align(center)[
      #text(17pt, smallcaps(title))
      #let count = authors.len()
      #let ncols = calc.min(count, 3)
      #grid(
        columns: (1fr,) * ncols,
        row-gutter: 24pt,
        ..authors.map(author => [
          #text(size: font.large, author.name)
          #if "email" in author [
            \ #text(size: font.small, font: "JetBrains Mono", link("mailto:" + author.email))
          ] else [
            \ #text(size: font.small, font: "JetBrains Mono", [\ ])
          ]
        ]),
      )
    ]
  )
  v(1em)

  body

  if bibliography != none {
    if "title" not in bibliography-opts {
      bibliography-opts.title = "References"
    }
    if "style" not in bibliography-opts {
      bibliography-opts.style = "ieee"
    }
    show std-bibliography: set text(size: font.small)
    set std-bibliography(..bibliography-opts)
    bibliography
  }
}

#let url(uri) = { return link(uri, raw(uri)) }
