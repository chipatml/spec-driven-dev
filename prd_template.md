# PRD: [Feature/Eval Name, e.g., Eval Dataset for Traffic Agents]

## Full Create PRD Prompt (From Ryan Carson's create-prd.md)
The generated PRD should include the following sections:
- Introduction/Overview: Briefly describe the feature and the problem it solves. State the goal.
- Goals: List the specific, measurable objectives for this feature.
- User Stories: Detail the user narratives describing feature usage and benefits.
- Functional Requirements: List the specific functionalities the feature must have. Use clear, concise language (e.g., "The system must allow users to upload a profile picture."). Number these requirements.
- Non-Goals (Out of Scope): Clearly state what this feature will not include to manage scope.
- Design Considerations (Optional): Link to mockups, describe UI/UX requirements, or mention relevant components/styles if applicable.
- Technical Considerations (Optional): Mention any known technical constraints, dependencies, or suggestions (e.g., "Should integrate with the existing Auth module").

Assume the primary reader of the PRD is a junior developer. Therefore, requirements should be explicit, unambiguous, and avoid jargon where possible.
Save PRD: Save the generated document as prd-[feature-name].md inside the /tasks directory.

## Problem Statement
[Describe issue]

## Goals and Objectives
[Goals]

## Requirements
### Functional
[Reqs]
### Non-Functional
[Reqs]
### Architectural
- [e.g., Use hexagonal architecture for agent isolation]

## User Stories
[Stories]

## Success Criteria
[Criteria]

## Assumptions/Risks
[Risks]

## LLM Prompt Integration
- Generated via: Describe feature and reference files (e.g., @agent-spec.md)
- For Refinement: "Refine the PRD based on feedback: [feedback details] using refine-prompt.md"

## Version History
[Details]