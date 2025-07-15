# School Manager Database

This project contains a lightweight Oracle SQL schema for a typical high school management system. It comes with sequences, tables and triggers for tracking students, teachers and courses.

## Features
- **Sequences** for automatically generated IDs
- **Tables** for students, teachers, subjects and grade reports
- **Many-to-many** mapping between courses and teachers
- **Triggers** to generate IDs and keep teacher counters
- **Validation** constraints for grade level and scores

## Getting Started
1. Clone the repository.
2. Connect to your Oracle database using `SQL*Plus` or `SQLcl`.
3. Execute `@init_all.sql` from the repo root to create all objects.

All schema scripts live in the `schema` folder so you can adjust them individually if needed.
