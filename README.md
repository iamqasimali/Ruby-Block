### 🧩 **Section 1: Blocks, Closures & Scope**

#### **Slide 1 — What Are Blocks?**

* A **block** is a chunk of code enclosed in `{}` or `do...end`
* Blocks can be passed to methods as arguments
* Example:

  ```ruby
  [1, 2, 3].each { |n| puts n * 2 }
  ```

---

#### **Slide 2 — Why Use Blocks**

* For **iteration**, **callbacks**, and **custom behavior**
* Let methods perform generic tasks but customize the details
* Example:

  ```ruby
  def repeat(times)
    times.times { yield }
  end

  repeat(3) { puts "Hello!" }
  ```

---

#### **Slide 3 — Variable Scope in Blocks**

* Variables defined inside a block **don’t leak out**
* But outer variables can be accessed inside

  ```ruby
  x = 10
  3.times { puts x } # OK
  puts y # Error, if y defined only inside block
  ```

---

#### **Slide 4 — Closures & Binding**

* A **closure** remembers variables from where it was defined
* Example:

  ```ruby
  def make_multiplier(n)
    ->(x) { x * n }
  end

  doubler = make_multiplier(2)
  puts doubler.call(5) # => 10
  ```

---

#### **Slide 5 — Creating Methods Using Blocks**

* `yield` executes the block passed to the method
* Example:

  ```ruby
  def greet
    yield("Qasim")
  end

  greet { |name| puts "Hello, #{name}!" }
  ```

---

#### **Slide 6 — Using `Proc` and `lambda`**

* Both store blocks as objects

  ```ruby
  square = Proc.new { |n| n * n }
  puts square.call(5)
  ```
* `lambda` checks argument count strictly, unlike `Proc`

---

#### **Slide 7 — Explicit Block Parameters**

* Capture block using `&block`

  ```ruby
  def run_twice(&block)
    block.call
    block.call
  end
  run_twice { puts "Run!" }
  ```

---

#### **Slide 8 — &:symbol Shorthand**

* Shortcut for simple block operations

  ```ruby
  names = ["ali", "qasim", "zahid"]
  puts names.map(&:capitalize)
  ```
* Equivalent to `{ |name| name.capitalize }`

---

#### **Slide 9 — Arity in Blocks and Methods**

* **Arity** = number of expected arguments
* Check using `.arity` method:

  ```ruby
  proc = ->(a, b) { a + b }
  puts proc.arity  # => 2
  ```

---

### 🧪 **Section 2: Testing in Ruby**

#### **Slide 10 — Testing Terminology**

* **Test suite**: all tests
* **Test case**: one group of related tests
* **Assertion**: condition to verify result
* **Setup/Teardown**: code before/after each test

---

#### **Slide 11 — Minitest vs RSpec**

| Feature           | Minitest         | RSpec                    |
| ----------------- | ---------------- | ------------------------ |
| Style             | Simple, built-in | DSL-like, expressive     |
| Syntax            | `assert_equal`   | `expect(...).to eq(...)` |
| Included in Ruby? | ✅ Yes            | ❌ No (Gem)               |

Example (RSpec):

```ruby
expect(add(2, 3)).to eq(5)
```

---

#### **Slide 12 — SEAT Approach**

**S**etup → **E**xercise → **A**ssert → **T**eardown

```ruby
def test_addition
  calculator = Calculator.new
  result = calculator.add(2, 3)
  assert_equal 5, result
end
```

---

#### **Slide 13 — Testing Equality**

* `assert_equal(expected, actual)` in Minitest
* `expect(actual).to eq(expected)` in RSpec

---

#### **Slide 14 — Common Assertions**

| Assertion         | Description                        |
| ----------------- | ---------------------------------- |
| `assert`          | True condition                     |
| `assert_equal`    | Checks equality                    |
| `assert_nil`      | Checks nil                         |
| `assert_includes` | Checks collection includes element |

---

### 📦 **Section 3: Packaging Ruby Code**

#### **Slide 15 — Ruby Version Managers**

* Tools to manage multiple Ruby versions

  * **rbenv**
  * **RVM**
  * **asdf**
* Example:

  ```bash
  rbenv install 3.1.3
  rbenv global 3.1.3
  ```

---

#### **Slide 16 — Bundler**

* Manages gem dependencies
* Key files:

  * `Gemfile`
  * `Gemfile.lock`
* Commands:

  ```bash
  bundle init
  bundle add rspec
  bundle install
  ```

---

#### **Slide 17 — Rake**

* Ruby's build & task runner
* Similar to “Makefile”
* Example `Rakefile`:

  ```ruby
  task :hello do
    puts "Hello from Rake!"
  end
  ```
* Run with:

  ```bash
  rake hello
  ```

---

#### **Slide 18 — Wrap-up**

* ✅ Blocks = reusable chunks of code
* ✅ Closures = remember context
* ✅ Testing ensures correctness
* ✅ Bundler, Rake = package and automate Ruby projects

---
double_proc = Proc.new { |i| puts i * 2 }


[1, 2, 3, 4, 5].each{ |i|  puts i * 2}


[1, 2, 3, 4, 5].each( &double_proc )


double_proc = Proc.new { |num| print num * 2 }



multiplication = lambda { |x, y| print x * y * 2 }
multiplication = -> { |x, y| print x * y * 2 }
