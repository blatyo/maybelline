# Maybelline

An implementation of the maybe monad.

## Usage

``` ruby
class B
  def b
    nil
  end
end

# if any method in the chain of calls returns nil, the 
# block will return nil
Maybe(B){|b| b.new.b.this_method_wont_get_called} #=> nil
B.maybe{|b| b.new.b.this_method_wont_get_called}  #=> nil

# if it is successful, it will return the value
1.maybe{|n| n.to_s(16).to_i.to_s(8)}              #=> 1
```