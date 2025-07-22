# Project Title: Agent-Based System with Eval Data Engineering

## Overview
- **Description**: [Summary]
- **Goals**: [e.g., Scalable eval via data pipelines]

## Architectural Strategy
- **Principles**: [e.g., SOLID, Loose coupling for agents]
- **Patterns**: [e.g., Event Sourcing for agent history]
- **Reference**: [Link to Architecture Overview]

## Agents and Environment
- **Agent Types**: [e.g., Reactive, architected as isolated services]

## Workflow Integration (Inspired by Ryan Carson)
- **PRD Initiation**: Start with @create-prd.md prompt for feature/eval specs.
- **Task Decomposition**: Use @generate-tasks.md to break into granular items.
- **Iterative Processing**: Process tasks sequentially with approval checkpoints.
- **Refinement Strategy**: Use feedback loops to refine outputs (e.g., PRDs, tasks) before approval; reference refine-prompt.md for structured feedback.

## Eval Data Strategy
- **Architecture**: [e.g., Lambda architecture for real-time/batch eval]

## Stakeholders
- **Architect Role**: [Oversee design reviews]

## Non-Functional Requirements
- **Eval Scalability**: [e.g., 1M data points via task batches]

## Assumptions and Constraints
- [e.g., LLM tools like Cursor for prompt execution]

## Version History
- [Details]