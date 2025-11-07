# Contributing to LiveKit Flutter Video Call

We welcome contributions to the LiveKit Flutter Video Call project! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Avoid harassment or discrimination
- Welcome diverse perspectives
- Focus on the code, not the person

## Getting Started

### 1. Fork and Clone

```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/your-username/livekit-flutter-video-call.git
cd livekit-flutter-video-call

# Add upstream remote
git remote add upstream https://github.com/original-repo/livekit-flutter-video-call.git
```

### 2. Create Feature Branch

```bash
# Update main branch
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 3. Setup Development Environment

Follow [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed instructions.

```bash
flutter pub get
flutter analyze
```

## Development Guidelines

### Code Style

#### Dart/Flutter Style Guide

```dart
// Follow these conventions:

// 1. File names: snake_case.dart
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// 2. Classes: PascalCase
class _MyWidgetState extends State<MyWidget> {
  // 3. Variables/Methods: camelCase
  String myVariable = '';
  
  void myMethod() {
    // 4. Constants: camelCase (prefer lowerCase)
    const myConstant = 'value';
  }
}

// 5. Always use const constructors
const SizedBox(height: 16)

// 6. Use trailing commas in multi-line lists
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Item 1'),
      Text('Item 2'),  // trailing comma
    ],
  );
}
```

### File Organization

```dart
// 1. Imports (organized groups)
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

// 2. Class definition
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// 3. State class
class _MyWidgetState extends State<MyWidget> {
  // Variables
  String _myVar = '';
  
  // Lifecycle methods
  @override
  void initState() {
    super.initState();
    // initialization
  }
  
  // Build method
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
  
  // Helper methods (private)
  void _myHelperMethod() {}
  
  // Dispose
  @override
  void dispose() {
    // cleanup
    super.dispose();
  }
}
```

### Comments

Use comments wisely:

```dart
// ✓ Good: Explains why, not what
// Use ListView instead of Column for scrolling performance
final list = ListView(children: items);

// ✗ Bad: Explains what the code does (obvious)
// Create a ListView widget
final list = ListView(children: items);

// ✓ Good: Doc comments for public APIs
/// Connects to a LiveKit room with the provided credentials.
/// 
/// Throws [ConnectionException] if connection fails.
Future<void> connect(String url, String token) async {
  // implementation
}

// ✗ Bad: Unnecessary comments
// Set name to value
name = 'John';
```

### Error Handling

```dart
// ✓ Good: Specific error handling
try {
  await _service.connect(url, token);
} on ConnectionException catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Connection failed: ${e.message}')),
  );
} catch (e) {
  FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
  rethrow;
}

// ✗ Bad: Generic error handling
try {
  await _service.connect(url, token);
} catch (e) {
  print('Error: $e');
}
```

### Testing

Write tests for new features:

```dart
// Unit test example
void main() {
  group('LiveKitService', () {
    late LiveKitService service;

    setUp(() {
      service = LiveKitService();
    });

    test('should initialize without errors', () {
      expect(service, isNotNull);
    });

    test('should connect to room', () async {
      // arrange
      const url = 'wss://test.livekit.cloud';
      const token = 'test-token';
      const room = 'test-room';

      // act
      await service.connect(url, token, room);

      // assert
      expect(service.room, isNotNull);
    });
  });
}
```

## Commit Guidelines

### Commit Message Format

Follow conventional commits:

```
type(scope): description

body (optional)

footer (optional)
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting)
- **refactor**: Code refactoring
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **chore**: Build or dependency updates

### Examples

```bash
# New feature
git commit -m "feat(video): add camera toggle button"

# Bug fix
git commit -m "fix(connection): handle network timeout properly"

# Documentation
git commit -m "docs(deployment): add iOS deployment steps"

# Multiple lines
git commit -m "feat(ui): improve participant grid layout

- Adjust spacing between tiles
- Add participant name display
- Fix orientation handling"
```

## Pull Request Process

### Before Submitting

1. **Ensure your code follows the style guide**
   ```bash
   dart format .
   flutter analyze
   ```

2. **Run tests**
   ```bash
   flutter test
   ```

3. **Update documentation**
   - Update README.md if needed
   - Add comments for complex code
   - Update CHANGELOG if applicable

4. **Test on actual devices**
   - Test on Android device/emulator
   - Test on iOS simulator (if possible)
   - Test on different Flutter versions

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] All tests passing

## Screenshots (if applicable)
Add screenshots for UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No breaking changes introduced
```

### Code Review Expectations

- Respond to review comments promptly
- Make requested changes on the same branch
- Request re-review after changes
- Be open to feedback and discussion

## Reporting Issues

### Bug Reports

Include:

```
## Description
Clear description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- Flutter version: X.X.X
- Device/OS: Android 12 / iOS 15
- App version: 1.0.0

## Logs
Relevant error messages or logs
```

### Feature Requests

Include:

```
## Description
Clear description of feature

## Use Case
Why this feature is needed

## Proposed Solution
Your suggested implementation

## Alternatives
Other possible approaches

## Additional Context
Any other relevant information
```

## Documentation

### Updating Docs

- Keep README.md up to date
- Update DEPLOYMENT.md for build changes
- Update SETUP_GUIDE.md for environment changes
- Add examples for new features

### Doc Comments

```dart
/// Brief description of the class/method
///
/// More detailed explanation if needed.
/// Can span multiple lines.
///
/// Example:
/// ```dart
/// final token = await service.generateToken();
/// ```
///
/// Parameters:
///   - param1: Description of param1
///
/// Returns:
/// Description of return value
///
/// Throws:
///   - [SomeException]: When something goes wrong
class MyClass {
}
```

## Review Process

1. Submit pull request
2. Automated checks run (linting, tests)
3. Community members review code
4. Address feedback
5. Merge when approved

## Recognition

Contributors will be:
- Added to CONTRIBUTORS.md
- Mentioned in release notes
- Recognized in project documentation

## Questions?

- Check existing issues and PRs
- Read documentation files
- Open a discussion issue
- Join LiveKit community

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing! 🎉

**Contributing Guide Last Updated**: 2024
