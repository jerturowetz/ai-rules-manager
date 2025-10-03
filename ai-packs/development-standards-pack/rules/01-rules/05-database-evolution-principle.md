---
id: database_evolution_principle
scope: global
category: architecture
description: "Prefer extending existing databases with new columns over creating separate databases for each feature"
tools_excluded: []
---

# Database Evolution Principle

When working with CSV-type databases, prefer extending existing databases with new columns rather than creating separate databases for everything.

## Core Principle

**Evolve, don't multiply.** Enhance existing data structures non-destructively rather than fragmenting data across multiple databases.

## Preferred Approach: Column Extension

### ✅ **Extend Existing Database:**
```csv
# Original users.csv
user_id,name,email,created_at
1,John Doe,john@example.com,2024-01-01
2,Jane Smith,jane@example.com,2024-01-02

# After adding subscription feature
user_id,name,email,created_at,subscription_tier,subscription_start
1,John Doe,john@example.com,2024-01-01,premium,2024-01-15
2,Jane Smith,jane@example.com,2024-01-02,basic,2024-01-10
```

### ❌ **Avoid Database Fragmentation:**
```csv
# users.csv
user_id,name,email,created_at
1,John Doe,john@example.com,2024-01-01

# subscriptions.csv (separate database)
user_id,subscription_tier,subscription_start  
1,premium,2024-01-15

# user_preferences.csv (another separate database)
user_id,theme,notifications
1,dark,enabled

# user_analytics.csv (yet another database)
user_id,last_login,page_views
1,2024-01-20,45
```

## When Column Extension Makes Sense

### ✅ **Good Candidates for Column Addition:**
- **Related user attributes** (preferences, settings, status)
- **Simple feature flags** (is_verified, is_premium)
- **Timestamp tracking** (last_updated, last_login)
- **Calculated fields** (total_orders, lifetime_value)
- **Status fields** (subscription_status, account_status)

### ✅ **Benefits:**
- **Single source of truth** - All user data in one place
- **Simpler queries** - No complex joins across multiple files
- **Easier maintenance** - One schema to manage
- **Better performance** - No cross-database lookups for basic operations
- **Clearer relationships** - Data naturally belongs together

## When to Create Separate Databases

### ✅ **Valid Reasons for Separation:**

#### High Volume/Performance Issues
```csv
# If user events table becomes massive (millions of rows)
users.csv          # User profiles (hundreds/thousands of rows)
user_events.csv    # Event tracking (millions of rows)
```

#### Fundamentally Different Entities
```csv
users.csv          # User entities
products.csv       # Product catalog
orders.csv         # Transaction records
```

#### Security/Access Separation
```csv
users.csv          # Public user data
user_secrets.csv   # API keys, encrypted data (restricted access)
```

#### Complex Relationships (Many-to-Many)
```csv
users.csv          # One user
user_skills.csv    # Many skills per user
skills.csv         # Skill definitions
```

## Implementation Guidelines

### Non-Destructive Column Addition
```python
# ✅ Safe column addition
def add_subscription_columns(csv_file):
    # Add columns with sensible defaults
    df['subscription_tier'] = df.get('subscription_tier', 'free')
    df['subscription_start'] = df.get('subscription_start', None)
    return df
```

### Gradual Migration
```python
# ✅ Migrate data gradually
def migrate_subscription_data():
    users_df = pd.read_csv('users.csv')
    subscriptions_df = pd.read_csv('subscriptions.csv')  # Old separate file
    
    # Merge subscription data into users
    merged = users_df.merge(subscriptions_df, on='user_id', how='left')
    merged.to_csv('users.csv', index=False)
    
    # Archive old file instead of deleting
    subscriptions_df.to_csv('archived/subscriptions_backup.csv', index=False)
```

### Handle Missing Data Gracefully
```python
# ✅ Robust handling of new columns
def get_user_subscription(user_id):
    user = users_df[users_df['user_id'] == user_id].iloc[0]
    
    # Handle cases where new columns might not exist for all rows
    tier = user.get('subscription_tier', 'free')
    start_date = user.get('subscription_start', None)
    
    return tier, start_date
```

## Decision Framework

Ask yourself before creating a new database:

1. **Is this data fundamentally about the same entity?**
   - User preferences → Add to users.csv
   - Product reviews → Separate reviews.csv

2. **Will queries commonly need both datasets?**
   - User profile + subscription status → Same database
   - User profile + detailed analytics → Consider separation

3. **Is performance becoming an issue?**
   - < 100K rows → Probably keep together
   - > 1M rows → Consider separation

4. **Do these fields have different update patterns?**
   - Profile updated occasionally, login timestamps updated frequently → Consider separation

## Common Patterns

### ✅ **User Profile Evolution:**
```csv
# Start simple
user_id,name,email

# Add authentication
user_id,name,email,password_hash,created_at

# Add preferences  
user_id,name,email,password_hash,created_at,theme,language,notifications

# Add subscription
user_id,name,email,password_hash,created_at,theme,language,notifications,subscription_tier,billing_cycle
```

### ✅ **Product Catalog Evolution:**
```csv
# Start with basics
product_id,name,price,description

# Add inventory tracking
product_id,name,price,description,stock_count,last_restocked

# Add categorization
product_id,name,price,description,stock_count,last_restocked,category,tags,featured
```

## Remember

- **Start simple** - Begin with broader schemas and refactor when necessary
- **Monitor performance** - Separate when file size/query performance becomes problematic  
- **Preserve relationships** - Keep related data together when it makes logical sense
- **Non-destructive changes** - Always add columns, rarely remove them

**A well-evolved single database is usually better than a constellation of tiny, fragmented databases.**