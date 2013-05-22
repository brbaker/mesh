/**
 * Code sample based off of http://rosettacode.org/wiki/Mandelbrot_set#Ruby
*/

frangen(start, extent, step)
{
    stride = fabs(step);
    n = f2i(fdivz(fabs(extent) +. stride -. 1.0, stride));
    count(fsign(extent) * n) | { start +. i2f($0) *. stride }
};
ffromton(x, y, n)
{
    frangen(x, if(flt(x, y), { y -. x +. 1.0 }, { fneg(x -. y) -. 1.0 }), n)
};
magnitude(a:(Double, Double))
{
    sqrt(fsq(a.0) +. fsq(a.1));
};






mandelbrot(a:(Double, Double))
{
    reduce({ a:((Double, Double), (Double, Double)) => 
            result = a.0;
            element = a.1;
            // Calculate: result^2 + element
            rr = (fsq(result.0) +. (fsq(result.1) *. -1.0), (result.0 *. result.1) +. (result.1 *. result.0));
            ((rr.0 +. element.0), (rr.1 +. element.1));
            }, a, rep(1000, a))
};

/*
ffromton(1.0, -1.0, 0.05) | {
    output = box([""]);
    ffromton(-2.0, 0.5, 0.0315) | {
        if(flt(magnitude(mandelbrot(($0, $$0))), 2.0), { output <- { append($0, "*") } }, { output <- { append($0, " ") } });
    };
    print(strjoin(*output, ""));
}
*/


width = f2i(fdivz(fabs(-2.0) +. 0.5, 0.0165));
ffromton(1.0, -1.0, 0.028) | {
    output = box(rep(width+1, " "));
    cols = ffromton(-2.0, 0.5, 0.0165); 
    pforn( index(cols),
        {
        index => value = cols[index];
        if(flt(magnitude(mandelbrot((value, $$0))), 2.0),
            { output <- { listset($0, index, "*"); } },
            {  output <- { listset($0, index, " "); } });
        },
        1
    );
    print(strjoin(*output, ""));
}