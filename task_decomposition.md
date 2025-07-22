# Task List for: [PRD Name]

## Overview
[From PRD: Summary of goals]

## Full Generate Tasks Prompt (From Ryan Carson's generate-tasks.md)
To guide an AI assistant in creating a detailed, step-by-step task list in Markdown format based on an existing Product Requirements Document (PRD). The task list should guide a developer through implementation.
Analyze PRD: The AI reads and analyzes the functional requirements, user stories, and other sections of the specified PRD.
Assess Current State: Review the existing codebase to understand existing infrastructure, architectural patterns and conventions. Also, identify any existing components or features that already exist and could be relevant to the PRD requirements. Then, identify existing related files, components, and utilities that can be leveraged or need modification.
Phase 1: Generate Parent Tasks: Based on the PRD analysis and current state assessment, create the file and generate the main, high-level tasks required to implement the feature.
Use your judgement on how many high-level tasks to use. It's likely to be about 5. Present these tasks to the user in the specified format (without sub-tasks yet). Inform the user: "I have generated the high-level tasks based on the PRD. Ready to generate the sub-tasks? Respond with 'Go' to proceed."
Wait for Confirmation: Pause and wait for the user to respond with "Go".
Phase 2: Generate Sub-Tasks: Once the user confirms, break down each parent task into smaller, actionable sub-tasks necessary to complete the parent task. Ensure sub-tasks logically follow from the parent task, cover the implementation details implied by the PRD, and consider existing codebase patterns where relevant without being constrained by them.
Identify Relevant Files: Based on the tasks and PRD, identify potential files that will need to be created or modified. List these under the Relevant Files section, including corresponding test files if applicable.
Save Task List: Save the generated document in the /tasks/ directory with the filename tasks-[prd-file-name].md, where [prd-file-name] matches the base name of the input PRD file.
The generated task list must follow this structure:
## Relevant Files
- `path/to/potential/file1.ts` - Brief description...
### Notes
- Unit tests should typically be placed alongside the code files they are testing...

The process explicitly requires a pause after generating parent tasks to get user confirmation ("Go") before proceeding to generate the detailed sub-tasks. This ensures the high-level plan aligns with user expectations before diving into details.

## Decomposed Tasks
1. [Task 1: e.g., Define data schema]
   - Subtasks: 1.1 [Detail], 1.2 [Detail]
2. [Task 2: e.g., LLM-generate 1k base samples]

## Dependencies
[Deps]

## LLM Prompt Integration
[Prompts]

## Approval Process
[Review]

## Version History
[Details]