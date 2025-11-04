
## 🧪 **Section 2: Testing in Ruby (Detailed Slides)**

---

### 🧩 **Slide 10 — Testing Terminology (Detailed)**

#### **1. Test Suite**

* The **complete collection** of all your test files in a project.
* Usually located in `/test` (Minitest) or `/spec` (RSpec).
* Example:

  ```
  test/
  ├── models/
  ├── controllers/
  └── helpers/
  ```
* Think of it as the **entire safety net** ensuring your code works as expected.

---

#### **2. Test Case**

* A **single class or context** that groups related tests.
* For example, you may have a test case for a specific class or method.

  ```ruby
  # minitest
  class CalculatorTest < Minitest::Test
    def test_addition
      assert_equal 5, Calculator.new.add(2, 3)
    end
  end
  ```
* In RSpec:

  ```ruby
  RSpec.describe Calculator do
    it "adds two numbers" do
      expect(Calculator.new.add(2, 3)).to eq(5)
    end
  end
  ```

---

#### **3. Assertion**

* An **assertion** is a statement that must be true for the test to pass.
* If the condition fails, the test fails.
* Example:

  ```ruby
  assert_equal 5, add(2, 3) # passes if result == 5
  ```
* Assertions are the **core** of testing — they verify correctness.

---

#### **4. Setup / Teardown**

* Used to prepare and clean up test environments.
* **Setup** runs before each test; **Teardown** runs after each test.
* Example:

  ```ruby
  class UserTest < Minitest::Test
    def setup
      @user = User.new("Qasim", "qasim@example.com")
    end

    def teardown
      @user = nil
    end

    def test_email
      assert_match /@/, @user.email
    end
  end
  ```
* In RSpec:

  ```ruby
  RSpec.describe User do
    before(:each) do
      @user = User.new("Qasim", "qasim@example.com")
    end

    after(:each) do
      @user = nil
    end
  end
  ```


### ⚖️ **Slide 11 — Minitest vs. RSpec (Detailed Comparison)**

| Feature               | **Minitest**                     | **RSpec**                          |
| --------------------- | -------------------------------- | ---------------------------------- |
| **Included in Ruby?** | ✅ Yes (Standard Library)         | ❌ No (Add via `gem install rspec`) |
| **Syntax Style**      | Classic & procedural             | DSL (Domain Specific Language)     |
| **Readability**       | More traditional                 | More human-readable                |
| **Speed**             | Slightly faster                  | Slightly slower (more abstraction) |
| **Setup Folder**      | `/test`                          | `/spec`                            |
| **Run Command**       | `ruby -Itest test/file_name.rb`  | `rspec spec/file_name_spec.rb`     |
| **Assertion Syntax**  | `assert_equal(expected, actual)` | `expect(actual).to eq(expected)`   |
| **Output Format**     | Simple                           | Rich (colored, descriptive output) |

---

#### 🧠 **Slide 11 Continued — Example: Same Test in Both Frameworks**

**✅ Minitest Example**

```ruby
require "minitest/autorun"

class CalculatorTest < Minitest::Test
  def test_addition
    result = 2 + 3
    assert_equal 5, result
  end
end
```

**✅ RSpec Example**

```ruby
RSpec.describe "Calculator" do
  it "adds two numbers" do
    result = 2 + 3
    expect(result).to eq(5)
  end
end
```

🗣 **Teaching Tip:**
Explain that both do the same thing — RSpec just makes the test more **descriptive and expressive**.

---

#### ⚙️ **Slide 12 — When to Use Which**

* **Minitest**

  * When you want minimal dependencies.
  * When working with smaller or built-in Ruby projects.
  * Easy to start (already part of Ruby).
* **RSpec**

  * When you want readable, behavior-driven tests (BDD).
  * When collaborating on larger teams.
  * Great for Rails projects (integrates well).

🗣 **Teaching Tip:**
You can say:

> “Minitest is like plain coffee — simple and effective.
> RSpec is like a latte — same caffeine, just smoother and fancier.”

---

