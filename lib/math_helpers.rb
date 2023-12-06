module MathHelpers
  def solve_quadratic_equation(a, b, c)
    sqrt_d = Math.sqrt(b*b - 4*a*c)
    x1 = (-b + sqrt_d)/(2.0*a)
    x2 = (-b - sqrt_d)/(2.0*a)
    [x1, x2].sort
  end

  def float_is_int?(x)
    x.to_i.to_f == x
  end
end
