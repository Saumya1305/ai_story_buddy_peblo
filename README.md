# AI Story Buddy - Peblo Flutter Developer Challenge

## Overview

AI Story Buddy is a Flutter-based interactive storytelling application built for Peblo's Flutter Developer Intern Challenge.

The app narrates a short story using Text-to-Speech (TTS) and automatically reveals a quiz after narration is completed. The experience is designed to be engaging, child-friendly, lightweight, and suitable for mid-range Android devices.

---

## Framework Choice

### Flutter + Riverpod

I chose Flutter because it allows rapid cross-platform development while maintaining a smooth user experience.

For state management, I used Riverpod because:

* Predictable state management
* Better separation of business logic and UI
* Reduced widget rebuilds
* Scalable architecture for future story and quiz expansion

---

## Features Implemented

### Story Narration

* Native Text-to-Speech using `flutter_tts`
* Loading state before narration
* Speaking state during narration
* Stop narration functionality
* Error handling support

### Interactive Quiz

* Quiz generated from JSON data
* Dynamic option rendering
* Supports any number of options without UI changes
* Correct answer validation
* Wrong answer feedback

### Gamification

* Confetti celebration on correct answer
* Happy Buddy state
* Shake animation for incorrect answers
* Haptic feedback on incorrect answers

---

## Audio → Quiz Transition

Flow:

Read Story Button

↓

TTS Initialization

↓

Narration Starts

↓

Narration Completion Callback

↓

Quiz Becomes Visible

The quiz is revealed only after the TTS completion handler fires successfully.

This transition is managed through Riverpod state updates.

---

## Data-Driven Quiz Implementation

Quiz content is loaded from a JSON structure:

```json
{
  "question": "What colour was Pip the Robot's lost gear?",
  "options": ["Red", "Green", "Blue", "Yellow"],
  "answer": "Blue"
}
```

The UI renders options dynamically using the list supplied in JSON.

This allows future backend responses with different questions and varying option counts (3, 4, 5, etc.) without requiring code changes.

---

## Audio Loading and Failure Handling

Implemented states:

* Idle
* Loading
* Speaking
* Completed
* Error

If narration fails, the user is presented with:

* Friendly error message
* Retry option

The app avoids crashes and handles failures gracefully.

---

## Caching Approach

Current implementation uses the device's native TTS engine.

Since speech is generated locally, additional caching is not required.

If remote audio APIs (e.g., ElevenLabs) were used, I would:

* Cache generated audio files locally
* Store audio paths using local storage
* Reuse cached audio for repeated story playback
* Reduce API calls and improve performance

---

## Performance Considerations

The app was designed for mid-range Android devices (~3GB RAM).

Optimizations include:

* Riverpod state isolation
* Lightweight animations
* Minimal widget rebuilds
* Local TTS instead of remote streaming
* Simple UI hierarchy

Animations such as confetti and shake effects are only triggered when required.

---

## AI Usage & Judgment

AI assistance was used for:

* Flutter architecture planning
* Riverpod implementation guidance
* UI refinement ideas
* Animation suggestions

### Suggestion Rejected

One suggestion was to hardcode quiz rendering directly into the screen.

This was rejected because Peblo explicitly required a data-driven quiz architecture.

Instead, a JSON-based model and dynamic rendering approach was implemented.

### Challenge Faced

The TTS completion callback was initially registered after calling `speak()`.

This occasionally prevented the quiz from appearing after narration.

The issue was resolved by registering the completion handler before triggering speech playback.

---

## Project Structure

```text
lib/
├── constants/
├── data/
├── models/
├── providers/
├── screens/
├── services/
└── widgets/
```

This structure separates UI, state management, business logic, and data models.

---

## Packages Used

* flutter_riverpod
* flutter_tts
* confetti
* flutter_animate

---

## Demo Flow

Read Story

↓

Speaking State

↓

Quiz Reveal

↓

Wrong Answer Feedback

↓

Correct Answer Celebration

↓

Happy Buddy State

---

## Repository

GitHub Repository:

https://github.com/Saumya1305/ai_story_buddy_peblo

