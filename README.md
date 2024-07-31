# Ringo_Media

A new Flutter project.

## Getting Started

### Build:
- this is assuming you already have flutter installed on the current device if not please refer to [flutter.dev](https://flutter.dev)
```bash
./build.sh
flutter run
```
#### Building android :
 ```bash
flutter build apk
```
#### Testing :
 ```bash
flutter test
```

***
## Project Structure:
### What is used in this project?

- Freezed Code generation for data classes
- Riverpod for dependency injection
- flutter_native_splash for native splash screen generation
- flutter_launcher_icons for app icons generation


### File structure:
```
|-- lib
`----- core - contains core classes and extensions
`----- features - contains all features
|      `---- feature_name
|            `------- data - contains feature data related classes
|            |        `-- datasources - contains feature data sources
|            |        `-- models - contains feature data models
|            |        `-- repositories - contains feature repositories
|            `-------  domain - contains feature domain related classes
|            |        `-- entities - contains feature entities
|            |        `-- repositories - contains feature repositories
|            |        `-- usecases - contains feature usecases
|            `------- presentation - contains feature presentation related classes
|                     `-- bloc - contains feature blocs
|                     `-- screens - contains feature pages
|                     `-- widgets - contains feature widgets
`------ generated - contains generated files
`------ navigation - contains app routes
```

### why use riverpod instead of other dependency injection libraries?:
- Riverpod is a state management library that uses the Provider pattern.
- Easy to test and mock.
- Easy to override dependencies in tests and different parts of the app tree.
- Object dependencies easy to manage and override.
- The model used to create providers offers compile time analysis (with provider there is a common mistake, forgetting to create provider in tree now eliminated wih riverpod).
- Provider package was created by Remi Rousselet, the creator of Riverpod.
- The author decided to create Riverpod to overcome Provider's limitations.
- flutter_bloc by default uses Provider for dependency injection under the hood.
- get_it heavily depends on static variables and is not easy to override in the app tree. 
