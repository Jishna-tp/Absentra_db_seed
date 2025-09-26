/*
  # Seed Initial Data for Absentra

  This migration populates the database with initial seed data for the Absentra leave management system.

  ## Data Structure:
  1. Departments - Core organizational units
  2. Employees - Staff members with hierarchical relationships
  3. Users - Authentication accounts linked to employees
  4. Holidays - Company-wide holidays
  5. Leave Policies - Rules governing different leave types
  6. Leave Balances - Employee leave allocations
  7. Leave Requests - Sample requests with approval workflows
  8. Workflow Configurations - Approval process definitions

  ## Important Notes:
  - Uses consistent UUID patterns for easy reference
  - Maintains proper foreign key relationships
  - Includes realistic data for testing and demonstration
  - Assumes corresponding auth.users entries exist
*/

-- Clear existing data (in reverse dependency order)
DELETE FROM approval_steps;
DELETE FROM leave_requests;
DELETE FROM leave_balances;
DELETE FROM leave_policies;
DELETE FROM holidays;
DELETE FROM users;
DELETE FROM employees;
DELETE FROM departments;
DELETE FROM workflow_configs;

-- 1. DEPARTMENTS
INSERT INTO departments (id, name, description, created_at, updated_at) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Engineering', 'Software Development and Technical Operations', now(), now()),
  ('22222222-2222-2222-2222-222222222222', 'Human Resources', 'People Operations and Employee Relations', now(), now()),
  ('33333333-3333-3333-3333-333333333333', 'Marketing', 'Marketing, Sales and Customer Relations', now(), now()),
  ('44444444-4444-4444-4444-444444444444', 'Finance', 'Financial Planning and Accounting', now(), now()),
  ('55555555-5555-5555-5555-555555555555', 'Operations', 'Business Operations and Process Management', now(), now());

-- 2. EMPLOYEES (with hierarchical relationships)
INSERT INTO employees (id, name, employee_id, department_id, position, manager_id, joining_date, email, status, created_at, updated_at) VALUES
  -- Senior Management
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Admin User', 'EMP001', '22222222-2222-2222-2222-222222222222', 'System Administrator', NULL, '2024-01-01', 'admin@company.com', 'active', now(), now()),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Sarah Johnson', 'EMP002', '22222222-2222-2222-2222-222222222222', 'HR Manager', NULL, '2024-01-15', 'sarah.johnson@company.com', 'active', now(), now()),
  
  -- Department Managers
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Mike Chen', 'EMP003', '11111111-1111-1111-1111-111111111111', 'Engineering Manager', NULL, '2024-02-01', 'mike.chen@company.com', 'active', now(), now()),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Lisa Rodriguez', 'EMP004', '33333333-3333-3333-3333-333333333333', 'Marketing Manager', NULL, '2024-02-10', 'lisa.rodriguez@company.com', 'active', now(), now()),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'David Kim', 'EMP005', '44444444-4444-4444-4444-444444444444', 'Finance Manager', NULL, '2024-02-15', 'david.kim@company.com', 'active', now(), now()),
  
  -- Team Members
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Emily Davis', 'EMP006', '11111111-1111-1111-1111-111111111111', 'Senior Software Developer', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '2024-02-20', 'emily.davis@company.com', 'active', now(), now()),
  ('gggggggg-gggg-gggg-gggg-gggggggggggg', 'John Smith', 'EMP007', '11111111-1111-1111-1111-111111111111', 'Software Developer', 'cccccccc-cccc-cccc-cccc-cccccccccccc', '2024-03-01', 'john.smith@company.com', 'active', now(), now()),
  ('hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'Anna Wilson', 'EMP008', '33333333-3333-3333-3333-333333333333', 'Marketing Specialist', 'dddddddd-dddd-dddd-dddd-dddddddddddd', '2024-03-10', 'anna.wilson@company.com', 'active', now(), now()),
  ('iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'Robert Brown', 'EMP009', '44444444-4444-4444-4444-444444444444', 'Financial Analyst', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '2024-03-15', 'robert.brown@company.com', 'active', now(), now()),
  ('jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'Maria Garcia', 'EMP010', '55555555-5555-5555-5555-555555555555', 'Operations Coordinator', NULL, '2024-03-20', 'maria.garcia@company.com', 'active', now(), now());

-- 3. USERS (linked to employees with different roles)
INSERT INTO users (id, username, email, employee_id, role, is_active, last_login, created_at, updated_at) VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'admin', 'admin@company.com', 'EMP001', 'admin', true, '2024-12-20 10:30:00+00', '2024-01-01 00:00:00+00', '2024-01-01 00:00:00+00'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'hr.manager', 'sarah.johnson@company.com', 'EMP002', 'hr', true, '2024-12-19 10:30:00+00', '2024-01-15 00:00:00+00', '2024-01-15 00:00:00+00'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'line.manager', 'mike.chen@company.com', 'EMP003', 'line_manager', true, '2024-12-18 10:30:00+00', '2024-02-01 00:00:00+00', '2024-02-01 00:00:00+00'),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'marketing.manager', 'lisa.rodriguez@company.com', 'EMP004', 'line_manager', true, '2024-12-17 10:30:00+00', '2024-02-10 00:00:00+00', '2024-02-10 00:00:00+00'),
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'finance.manager', 'david.kim@company.com', 'EMP005', 'line_manager', true, '2024-12-16 10:30:00+00', '2024-02-15 00:00:00+00', '2024-02-15 00:00:00+00'),
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'employee', 'emily.davis@company.com', 'EMP006', 'employee', true, '2024-12-15 10:30:00+00', '2024-02-20 00:00:00+00', '2024-02-20 00:00:00+00'),
  ('gggggggg-gggg-gggg-gggg-gggggggggggg', 'john.smith', 'john.smith@company.com', 'EMP007', 'employee', true, '2024-12-14 10:30:00+00', '2024-03-01 00:00:00+00', '2024-03-01 00:00:00+00'),
  ('hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'anna.wilson', 'anna.wilson@company.com', 'EMP008', 'employee', true, '2024-12-13 10:30:00+00', '2024-03-10 00:00:00+00', '2024-03-10 00:00:00+00'),
  ('iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'robert.brown', 'robert.brown@company.com', 'EMP009', 'employee', true, '2024-12-12 10:30:00+00', '2024-03-15 00:00:00+00', '2024-03-15 00:00:00+00'),
  ('jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'maria.garcia', 'maria.garcia@company.com', 'EMP010', 'employee', true, '2024-12-11 10:30:00+00', '2024-03-20 00:00:00+00', '2024-03-20 00:00:00+00');

-- 4. HOLIDAYS (current and upcoming)
INSERT INTO holidays (id, name, date, description, created_at, updated_at) VALUES
  ('h1111111-1111-1111-1111-111111111111', 'New Year''s Day', '2025-01-01', 'Public Holiday - Start of the new year', now(), now()),
  ('h2222222-2222-2222-2222-222222222222', 'Martin Luther King Jr. Day', '2025-01-20', 'Federal Holiday', now(), now()),
  ('h3333333-3333-3333-3333-333333333333', 'Presidents Day', '2025-02-17', 'Federal Holiday', now(), now()),
  ('h4444444-4444-4444-4444-444444444444', 'Memorial Day', '2025-05-26', 'Federal Holiday', now(), now()),
  ('h5555555-5555-5555-5555-555555555555', 'Independence Day', '2025-07-04', 'National Holiday - Independence Day', now(), now()),
  ('h6666666-6666-6666-6666-666666666666', 'Labor Day', '2025-09-01', 'Federal Holiday', now(), now()),
  ('h7777777-7777-7777-7777-777777777777', 'Thanksgiving Day', '2025-11-27', 'Federal Holiday', now(), now()),
  ('h8888888-8888-8888-8888-888888888888', 'Christmas Day', '2025-12-25', 'Religious Holiday - Christmas celebration', now(), now());

-- 5. LEAVE POLICIES (comprehensive policies for all leave types)
INSERT INTO leave_policies (id, leave_type, annual_limit, min_days_notice, max_consecutive_days, carry_forward_allowed, carry_forward_limit, requires_medical_certificate, is_active, created_at, updated_at) VALUES
  ('p1111111-1111-1111-1111-111111111111', 'casual', 12, 2, 5, true, 5, false, true, now(), now()),
  ('p2222222-2222-2222-2222-222222222222', 'sick', 10, 0, 10, false, NULL, true, true, now(), now()),
  ('p3333333-3333-3333-3333-333333333333', 'paid', 20, 7, 15, true, 10, false, true, now(), now()),
  ('p4444444-4444-4444-4444-444444444444', 'personal', 8, 3, 5, false, NULL, false, true, now(), now()),
  ('p5555555-5555-5555-5555-555555555555', 'maternity', 90, 30, 90, false, NULL, true, true, now(), now()),
  ('p6666666-6666-6666-6666-666666666666', 'paternity', 14, 30, 14, false, NULL, false, true, now(), now());

-- 6. LEAVE BALANCES (for all employees)
INSERT INTO leave_balances (id, employee_id, leave_type, year, total_days, used_days, remaining_days, carried_forward_days, created_at, updated_at) VALUES
  -- Emily Davis (EMP006) balances
  ('b1111111-1111-1111-1111-111111111111', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'casual', 2024, 12, 3, 9, 0, now(), now()),
  ('b1111112-1111-1111-1111-111111111111', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'sick', 2024, 10, 1, 9, 0, now(), now()),
  ('b1111113-1111-1111-1111-111111111111', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'paid', 2024, 20, 5, 15, 0, now(), now()),
  ('b1111114-1111-1111-1111-111111111111', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'personal', 2024, 8, 2, 6, 0, now(), now()),
  
  -- John Smith (EMP007) balances
  ('b2222221-2222-2222-2222-222222222222', 'gggggggg-gggg-gggg-gggg-gggggggggggg', 'casual', 2024, 12, 2, 10, 0, now(), now()),
  ('b2222222-2222-2222-2222-222222222222', 'gggggggg-gggg-gggg-gggg-gggggggggggg', 'sick', 2024, 10, 0, 10, 0, now(), now()),
  ('b2222223-2222-2222-2222-222222222222', 'gggggggg-gggg-gggg-gggg-gggggggggggg', 'paid', 2024, 20, 3, 17, 0, now(), now()),
  ('b2222224-2222-2222-2222-222222222222', 'gggggggg-gggg-gggg-gggg-gggggggggggg', 'personal', 2024, 8, 1, 7, 0, now(), now()),
  
  -- Anna Wilson (EMP008) balances
  ('b3333331-3333-3333-3333-333333333333', 'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'casual', 2024, 12, 4, 8, 0, now(), now()),
  ('b3333332-3333-3333-3333-333333333333', 'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'sick', 2024, 10, 2, 8, 0, now(), now()),
  ('b3333333-3333-3333-3333-333333333333', 'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'paid', 2024, 20, 6, 14, 0, now(), now()),
  ('b3333334-3333-3333-3333-333333333333', 'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'personal', 2024, 8, 1, 7, 0, now(), now()),
  
  -- Robert Brown (EMP009) balances
  ('b4444441-4444-4444-4444-444444444444', 'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'casual', 2024, 12, 1, 11, 0, now(), now()),
  ('b4444442-4444-4444-4444-444444444444', 'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'sick', 2024, 10, 0, 10, 0, now(), now()),
  ('b4444443-4444-4444-4444-444444444444', 'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'paid', 2024, 20, 2, 18, 0, now(), now()),
  ('b4444444-4444-4444-4444-444444444444', 'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'personal', 2024, 8, 0, 8, 0, now(), now()),
  
  -- Maria Garcia (EMP010) balances
  ('b5555551-5555-5555-5555-555555555555', 'jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'casual', 2024, 12, 2, 10, 0, now(), now()),
  ('b5555552-5555-5555-5555-555555555555', 'jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'sick', 2024, 10, 1, 9, 0, now(), now()),
  ('b5555553-5555-5555-5555-555555555555', 'jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'paid', 2024, 20, 4, 16, 0, now(), now()),
  ('b5555554-5555-5555-5555-555555555555', 'jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'personal', 2024, 8, 1, 7, 0, now(), now());

-- 7. WORKFLOW CONFIGURATIONS
INSERT INTO workflow_configs (id, name, steps, is_active, created_at, updated_at) VALUES
  ('w1111111-1111-1111-1111-111111111111', 'Standard Employee Workflow', 
   '[{"order": 1, "role": "line_manager", "required": true}, {"order": 2, "role": "hr", "required": true}]'::jsonb, 
   true, now(), now()),
  ('w2222222-2222-2222-2222-222222222222', 'Manager Workflow', 
   '[{"order": 1, "role": "hr", "required": true}]'::jsonb, 
   true, now(), now()),
  ('w3333333-3333-3333-3333-333333333333', 'HR Auto-Approval', 
   '[{"order": 1, "role": "hr", "required": false}]'::jsonb, 
   true, now(), now());

-- 8. LEAVE REQUESTS (with various statuses and approval workflows)
INSERT INTO leave_requests (id, employee_id, leave_type, from_date, to_date, reason, status, days_count, created_at, updated_at) VALUES
  -- Pending request from Emily Davis
  ('r1111111-1111-1111-1111-111111111111', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 'casual', '2024-12-23', '2024-12-27', 'Christmas vacation with family', 'pending', 5, '2024-12-20 09:00:00+00', '2024-12-20 09:00:00+00'),
  
  -- Approved request from John Smith
  ('r2222222-2222-2222-2222-222222222222', 'gggggggg-gggg-gggg-gggg-gggggggggggg', 'paid', '2024-12-30', '2025-01-03', 'New Year break', 'approved', 5, '2024-12-15 10:00:00+00', '2024-12-18 14:30:00+00'),
  
  -- Rejected request from Anna Wilson
  ('r3333333-3333-3333-3333-333333333333', 'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'personal', '2024-12-24', '2024-12-26', 'Personal matters', 'rejected', 3, '2024-12-16 11:00:00+00', '2024-12-17 16:00:00+00'),
  
  -- Another pending request from Robert Brown
  ('r4444444-4444-4444-4444-444444444444', 'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii', 'sick', '2024-12-21', '2024-12-21', 'Medical appointment', 'pending', 1, '2024-12-19 08:30:00+00', '2024-12-19 08:30:00+00'),
  
  -- Approved request from Maria Garcia
  ('r5555555-5555-5555-5555-555555555555', 'jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj', 'casual', '2025-01-15', '2025-01-17', 'Long weekend trip', 'approved', 3, '2024-12-10 12:00:00+00', '2024-12-12 10:00:00+00');

-- 9. APPROVAL STEPS (for the leave requests above)
INSERT INTO approval_steps (id, leave_request_id, step_order, approver_role, approver_id, status, comments, approved_at, is_current, created_at, updated_at) VALUES
  -- Emily's pending request - awaiting line manager approval
  ('a1111111-1111-1111-1111-111111111111', 'r1111111-1111-1111-1111-111111111111', 1, 'line_manager', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'pending', NULL, NULL, true, '2024-12-20 09:00:00+00', '2024-12-20 09:00:00+00'),
  ('a1111112-1111-1111-1111-111111111111', 'r1111111-1111-1111-1111-111111111111', 2, 'hr', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending', NULL, NULL, false, '2024-12-20 09:00:00+00', '2024-12-20 09:00:00+00'),
  
  -- John's approved request - both approvals completed
  ('a2222221-2222-2222-2222-222222222222', 'r2222222-2222-2222-2222-222222222222', 1, 'line_manager', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 'approved', 'Approved for New Year break', '2024-12-16 10:00:00+00', false, '2024-12-15 10:00:00+00', '2024-12-16 10:00:00+00'),
  ('a2222222-2222-2222-2222-222222222222', 'r2222222-2222-2222-2222-222222222222', 2, 'hr', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'approved', 'Final approval granted', '2024-12-18 14:30:00+00', false, '2024-12-15 10:00:00+00', '2024-12-18 14:30:00+00'),
  
  -- Anna's rejected request - rejected at line manager level
  ('a3333331-3333-3333-3333-333333333333', 'r3333333-3333-3333-3333-333333333333', 1, 'line_manager', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 'rejected', 'Cannot approve during peak holiday season', '2024-12-17 16:00:00+00', false, '2024-12-16 11:00:00+00', '2024-12-17 16:00:00+00'),
  ('a3333332-3333-3333-3333-333333333333', 'r3333333-3333-3333-3333-333333333333', 2, 'hr', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending', NULL, NULL, false, '2024-12-16 11:00:00+00', '2024-12-16 11:00:00+00'),
  
  -- Robert's pending sick leave - awaiting line manager approval
  ('a4444441-4444-4444-4444-444444444444', 'r4444444-4444-4444-4444-444444444444', 1, 'line_manager', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'pending', NULL, NULL, true, '2024-12-19 08:30:00+00', '2024-12-19 08:30:00+00'),
  ('a4444442-4444-4444-4444-444444444444', 'r4444444-4444-4444-4444-444444444444', 2, 'hr', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'pending', NULL, NULL, false, '2024-12-19 08:30:00+00', '2024-12-19 08:30:00+00'),
  
  -- Maria's approved request - both approvals completed (no line manager, direct HR approval)
  ('a5555551-5555-5555-5555-555555555555', 'r5555555-5555-5555-5555-555555555555', 1, 'hr', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'approved', 'Approved for long weekend', '2024-12-12 10:00:00+00', false, '2024-12-10 12:00:00+00', '2024-12-12 10:00:00+00');

-- Success message
DO $$
BEGIN
    RAISE NOTICE 'Absentra seed data has been successfully inserted!';
    RAISE NOTICE 'Created:';
    RAISE NOTICE '- 5 Departments';
    RAISE NOTICE '- 10 Employees with hierarchical relationships';
    RAISE NOTICE '- 10 Users with different roles';
    RAISE NOTICE '- 8 Company holidays';
    RAISE NOTICE '- 6 Leave policies';
    RAISE NOTICE '- 20 Leave balance records';
    RAISE NOTICE '- 3 Workflow configurations';
    RAISE NOTICE '- 5 Leave requests with approval workflows';
    RAISE NOTICE '- 9 Approval steps';
    RAISE NOTICE '';
    RAISE NOTICE 'Default login credentials:';
    RAISE NOTICE '- Admin: admin / password';
    RAISE NOTICE '- HR Manager: hr.manager / password';
    RAISE NOTICE '- Line Manager: line.manager / password';
    RAISE NOTICE '- Employee: employee / password';
END $$;