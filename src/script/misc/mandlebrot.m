/**
 * Code sample based off of http://rosettacode.org/wiki/Mandelbrot_set#Ruby
*/

frangen(start:Double, extent:Double, step:Double)
{
    stride:Double = fabs(step);
    n = f2i(fdivz(fabs(extent) +. stride -. 1.0, stride));
    count(fsign(extent) * n) | { start +. i2f($0) *. stride }
};
ffromton(x, y, n)
{
    frangen(x, if(flt(x, y), { y -. x +. 1.0 }, { fneg(x -. y) -. 1.0 }), n)
};

mandelbrot(a:(Double, Double)) -> (Double, Double)
{
    reduce({ a:((Double, Double), (Double, Double)) => 
            result:(Double, Double) = a.0;
            element:(Double, Double) = a.1;
            rr:(Double, Double) = ((result.0 *. result.0) +. ((result.1 *. result.1) *. -1.0), (result.0 *. result.1) +. (result.1 *. result.0));
            addz:(Double, Double) = ((rr.0 +. element.0), (rr.1 +. element.1));
            (addz)
            }, a, rep(50, a))
};

magnitude(a:(Double, Double)) -> Double
{
    sqrt(fsq(a.0) +. fsq(a.1));
};

ffromton(1.0, -1.0, 0.05) | {
    output = box([""]);
    ffromton(-2.0, 0.5, 0.0315) | {
        //print(mandelbrot(($$0, $0)));
        if(flt(magnitude(mandelbrot(($0, $$0))), 2.0), { output <- { append($0, "*") } }, { output <- { append($0, " ") } });
    };
    print(strjoin(*output, ""));
}