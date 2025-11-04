## 🕐 **1️⃣ Cron Jobs**

### **What is a Cron Job?**

A **cron job** is a **scheduled task** that runs automatically at specific time intervals on your server (like daily, hourly, or every Monday at 2 AM).

Think of it as a *background scheduler* — used for things you want to happen automatically (e.g., sending reminders, clearing logs, or generating reports).

---

### **🔧 Example: Cron Job in Rails**

Let’s say you want to send users a daily email at midnight.

1. **Create a Rake task or service** that sends emails
   (We’ll cover rake task next 👇)

2. **Use a scheduler gem**, such as:

   * [`whenever`](https://github.com/javan/whenever) (most common)
   * or Linux `crontab` directly

---

### **💡 Using Whenever Gem Example**

**Step 1:** Add gem in Gemfile

```ruby
gem 'whenever', require: false
```

**Step 2:** Run setup

```bash
bundle exec wheneverize .
```

This creates a `config/schedule.rb` file.

**Step 3:** Define your cron schedule:

```ruby
# config/schedule.rb
set :output, "log/cron.log"

every 1.day, at: '12:00 am' do
  rake "emails:daily_summary"
end
```

**Step 4:** Update cron jobs on the server:

```bash
whenever --update-crontab
```

✅ **Now your Rails app will automatically run that Rake task every midnight.**

---

## 🧹 **2️⃣ Rake Tasks**

### **What is a Rake Task?**

A **Rake task** is like a **custom Ruby command** you can run from the terminal — it performs automation or maintenance tasks for your app.

Rails uses **Rake** to:

* Migrate the database
* Clear cache
* Import data
* Send emails
* Or any custom logic you define

---

### **📄 Example: Custom Rake Task**

**File:** `lib/tasks/emails.rake`

```ruby
namespace :emails do
  desc "Send daily summary emails to users"
  task daily_summary: :environment do
    User.find_each do |user|
      UserMailer.daily_summary(user).deliver_now
    end
    puts "✅ Daily summary emails sent successfully!"
  end
end
```

Now you can run it manually:

```bash
rails emails:daily_summary
```

---

## 🔗 **Cron Jobs + Rake Tasks Together**

They often work **together**:

* **Rake task** = defines *what* to do
* **Cron job** = defines *when* to do it

For example:

> “Run the `emails:daily_summary` Rake task every day at 12 AM”

---

## ⚙️ **Real-World Use Cases**

| Task                                  | Tool        | Frequency   |
| ------------------------------------- | ----------- | ----------- |
| Send daily reports                    | Cron + Rake | Every day   |
| Cleanup old sessions                  | Rake        | Hourly      |
| Auto-deactivate expired subscriptions | Cron + Rake | Every night |
| Database backup                       | Cron + Rake | Weekly      |

---

## 🧭 **Quick Summary**

| Feature     | Cron Job                 | Rake Task                    |
| ----------- | ------------------------ | ---------------------------- |
| Purpose     | Schedule recurring tasks | Define automation logic      |
| Runs        | Automatically (via OS)   | Manually (`rails task:name`) |
| File        | `config/schedule.rb`     | `lib/tasks/*.rake`           |
| Common Tool | Whenever gem             | Built-in Rails Rake          |

---
