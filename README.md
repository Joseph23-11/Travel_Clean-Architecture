# travel_course

A new Flutter project.

# File Structure

```bash
 lib
 ├── core
 │   ├── error
 │   │   ├── exceptions.dart
 │   │   └── failures.dart
 │   ├── platform
 │   │   └── network_info.dart
 │   ├── usecases
 │   │   ├── fetch_token.dart
 │   │   └── usecase.dart
 │   ├── utils
 │   │   ├── constants.dart
 │   │   ├── router.dart
 │   │   └── theme.dart
 │   └── widgets
 │       └── custom_snak_bar.dart
 ├── injection_container.dart
 ├── main.dart
 └── feautures
     ├── destination
         ├── data
         │   ├── datasources
         │   │   ├── destination_local_datasource.dart
         │   │   └── destination_remote_datasource.dart
         │   ├── models
         │   │   └── destination_model.dart
         │   └── repositories
         │       └── destination_repository_impl.dart
         ├── domain
         │   ├── entities
         │   │   ├── destination_entity.dart
         │   │   └── destination_repositiries.dart
         │   ├── repositories
         │   │   └── destination_model.dart
         │   └── usecases
         │       ├── get_all_destination_usecase.dart
         │       ├── get_top_destination_usecase.dart
         │       └── search_destination_usecase.dart
         └── presentation
             ├── blocs
             │   └── change_password
             │       ├── bloc.dart
             │       ├── change_password_bloc.dart
             │       ├── change_password_event.dart
             │  
             └── cubit
                 └── change_password.dart

```

<br />

<h3 align="center">Architecture Proposal</h3>

<br />

<img src="./architecture-proposal.png" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

<br />
<br />
