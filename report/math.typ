#import "@preview/physica:0.9.3": pdv, dv

#let mb(A) = math.bold(math.upright(A))
#let vb(x) = math.bold(x)
#let Sum(idx, a, b) = math.attach(math.sum, b: [#idx #math.eq #a], t: b)
#let Product(idx, a, b) = math.attach(math.product, b: [#idx #math.eq #a], t: b)
#let Lim(x, c) = math.attach(math.lim, b: [#x #math.arrow.r #c])
#let Integral(..args) = {
  if args.pos().len() == 2 {
    let (f, dif) = args.pos()
    [#math.integral #f #math.dif #dif]
  } else if args.pos().len() == 3 {
    let (lower, f, dif) = args.pos()
    [#math.attach(math.integral, b: lower) #f #math.dif #dif]
  } else if args.pos().len() == 4 {
    let (lower, upper, f, dif) = args.pos()
    [#math.attach(math.integral, b: lower, t: upper) #f #math.dif #dif]
  }
}

#let ReLU     = math.op("ReLU")
#let softmax  = math.op("softmax")
#let logistic = math.op("logistic")
#let logit    = math.op("logit")
#let Cov      = math.op("Cov")
#let corr     = math.op("corr")
#let span     = math.op("span")
#let rk       = math.op("rk")
#let diag     = math.op("diag")
#let null     = math.op("null")
#let range    = math.op("range")
#let ND       = math.op("ND")
#let Pa       = math.op("Pa")
#let ind      = math.bot + h(-0.6em) + math.bot
#let Ber      = math.op("Ber")
#let Bin      = math.op("Bin")
#let Cat      = math.op("Cat")
#let Pois     = math.op("Pois")
