Excellent — let’s put it all together clearly and professionally so you can **teach “Callbacks in Rails”** with confidence.

Below is a **complete explanation + examples** for both **Model Hooks (ActiveRecord Callbacks)** and **Controller Callbacks (ActionController Filters)**, formatted like presentation notes (ideal for slides or teaching).

---

## ⚙️ **Callbacks in Ruby on Rails**

### 🔹 What Are Callbacks?

Callbacks are **methods that run automatically** at certain points in an object’s **lifecycle** — either for a **Model** (database record) or a **Controller** (HTTP request cycle).

They let you:

* Run logic automatically (without repeating code)
* Keep your code DRY and organized
* Manage pre/post actions easily

---

## 🧩 **1️⃣ Model Callbacks (Hooks)**

These are **ActiveRecord callbacks**, used to trigger code **before or after** certain database actions (like `save`, `create`, `update`, or `destroy`).

---

### 🔸 **Common Model Callback Types**

| Category       | Callback Methods                                    | Description                           |
| -------------- | --------------------------------------------------- | ------------------------------------- |
| **Validation** | `before_validation`, `after_validation`             | Triggered when the model is validated |
| **Saving**     | `before_save`, `around_save`, `after_save`          | When saving (on both create & update) |
| **Creation**   | `before_create`, `around_create`, `after_create`    | Only when creating new record         |
| **Updating**   | `before_update`, `after_update`                     | Only when updating record             |
| **Destroying** | `before_destroy`, `around_destroy`, `after_destroy` | When deleting record                  |
| **Commit**     | `after_commit`, `after_rollback`                    | After database transaction completes  |

---

### 💾 **Example: before_save**

```ruby
class User < ApplicationRecord
  before_save :format_name

  private

  def format_name
    self.name = name.strip.titleize
  end
end
```

✅ **Explanation:**
Before saving the user (on create or update), the name is cleaned and properly formatted.

---

### 🪄 **Example: before_create**

```ruby
class Order < ApplicationRecord
  before_create :set_order_number

  private

  def set_order_number
    self.order_number = "ORD#{Time.now.to_i}"
  end
end
```

✅ **Explanation:**
Automatically assigns a unique order number when a new order is created.

---

### 🧨 **Example: before_destroy**

```ruby
class Account < ApplicationRecord
  before_destroy :check_balance

  private

  def check_balance
    if balance > 0
      throw(:abort)  # stops the destroy action
    end
  end
end
```

✅ **Explanation:**
Prevents deleting an account if it still has money.

---

### 📩 **Example: after_commit**

```ruby
class Invoice < ApplicationRecord
  after_commit :send_email, on: :create

  private

  def send_email
    InvoiceMailer.confirmation(self).deliver_later
  end
end
```

✅ **Explanation:**
Runs **after** the transaction is fully committed — safe for external actions like sending emails.

---

### ⚠️ **Model Callback Best Practices**

* Keep callbacks **lightweight** — avoid long business logic.
* Use them mainly for **data consistency** (formatting, validation, auditing).
* For heavy logic, use **Service Objects or Jobs**.
* Avoid chaining too many callbacks — it can make debugging harder.

---

## 🧭 **2️⃣ Controller Callbacks (Filters)**

These are **ActionController callbacks** — they let you run logic **before, after, or around controller actions**.

---

### 🔸 **Common Controller Callback Types**

| Callback        | Description                                                   |
| --------------- | ------------------------------------------------------------- |
| `before_action` | Runs **before** the action method                             |
| `after_action`  | Runs **after** the action method                              |
| `around_action` | Runs **before and after**, wrapping the action                |
| *(Old Names)*   | `before_filter`, `after_filter`, `around_filter` (deprecated) |

---

### 🧠 **Example: before_action**

```ruby
class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: [:show, :edit]

  def show
    # @project is already loaded
  end

  private

  def authenticate_user!
    redirect_to login_path, alert: "Please log in!" unless current_user
  end

  def load_project
    @project = Project.find(params[:id])
  end
end
```

✅ **Explanation:**
Before executing `show` or `edit`, Rails ensures the user is authenticated and the project is loaded.

---

### 🧠 **Example: after_action**

```ruby
class UsersController < ApplicationController
  after_action :log_action, only: [:create, :update]

  def create
    # user creation logic
  end

  private

  def log_action
    Rails.logger.info "User action completed at #{Time.now}"
  end
end
```

✅ **Explanation:**
After user creation or update, a log entry is written.

---

### 🧠 **Example: around_action**

```ruby
class PaymentsController < ApplicationController
  around_action :measure_time

  def create
    # Payment processing
    sleep 2
  end

  private

  def measure_time
    start = Time.now
    yield  # runs the actual controller action
    finish = Time.now
    Rails.logger.info "Action took #{finish - start} seconds"
  end
end
```

✅ **Explanation:**
`around_action` wraps the controller action — great for timing, benchmarking, or transactions.

---

### ⚙️ **Conditional Filters**

You can specify **when** filters run.

```ruby
before_action :require_admin, if: -> { current_user.admin? }
before_action :authenticate_user!, unless: -> { action_name == "public" }
```

✅ **Explanation:**
Run `require_admin` only if the current user is an admin.
Skip authentication for public pages.

---

## 🧩 **Summary: Callbacks in Rails**

| Type               | Applies To | Example                       | Purpose                  |
| ------------------ | ---------- | ----------------------------- | ------------------------ |
| **before_save**    | Model      | `before_save :normalize_name` | Data consistency         |
| **after_create**   | Model      | Send email after creation     | Post-processing          |
| **before_destroy** | Model      | `throw(:abort)`               | Prevent invalid deletion |
| **before_action**  | Controller | Auth check                    | Access control           |
| **after_action**   | Controller | Logging                       | Tracking or cleanup      |
| **around_action**  | Controller | Time measurement              | Wrapping logic           |

---

### 🧠 **Teaching Analogy**

> Model callbacks are like “automatic internal rules” —
> (e.g., clean your data before saving it).
>
> Controller callbacks are like “guards at the door” —
> (e.g., check authentication before letting you in).

---

Would you like me to turn this into **slide format (PowerPoint / Google Slides)** next — with visual flow diagrams (Model Lifecycle & Controller Request Flow) and short examples per slide for teaching?
