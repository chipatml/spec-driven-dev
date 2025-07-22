# Process Task List for: [Task List Name]

## Full Process Task List Prompt (From Ryan Carson's process-task-list.md)
Guidelines for managing task lists in markdown files to track progress on completing a PRD.
One sub-task at a time: Do NOT start the next sub-task until you ask the user for permission and they say "yes" or "y".
When you finish a sub-task, immediately mark it as completed by changing [ ] to [x].
If all subtasks underneath a parent task are now [x], follow this sequence:
First: Run the full test suite (pytest, npm test, bin/rails test, etc.).
Then: Commit the changes to git with a meaningful commit message, including a short title, bullet points for key changes, and reference to related tasks/PRD.
e.g., git commit -m "feat: add payment validation logic" -m "- Validates card type and expiry" -m "- Adds unit tests for edge cases" -m "Related to T123 in PRD"
Once all the subtasks are completed and changes have been committed, mark the parent task as completed.
Stop after each sub-task and wait for the user’s go-ahead.
Mark tasks and subtasks as completed ([x]) per the protocol above. Add new tasks as they emerge.

## Instructions
- Tackle one task at a time from the list.
- Generate output (e.g., code, data samples).
- Wait for approval: Respond with "yes" or feedback.

## Current Task
- [e.g., Task 1.1: Implement schema]
  - LLM Output: [Placeholder for generation]

## Progress Tracking
- Completed: [List]
- Pending: [List]

## Architectural Checkpoint
- [e.g., Verify modularity]

## LLM Prompt Integration
- Reference task list (@tasks.md) and PRD.

## Evaluation Checkpoint
- [Metrics for this task]

## Version History
[Details]