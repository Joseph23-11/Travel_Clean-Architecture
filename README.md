# Travel Project on Clean Architecture

## File Structure

```bash
 lib
 ├── api
 │   └── utils.dart
 ├── core
 │   ├── error
 │   │   ├── exceptions.dart
 │   │   └── failures.dart
 │   └── platform
 │       └── network_info.dart
 ├── common
 │   └── utils.dart
 ├── injection_container.dart
 ├── main.dart
 └── feautures
     └── destination
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
             ├── bloc
             │   ├── all_destination
             │   │   ├── all_destination_event.dart
             │   │   ├── all_destination_bloc.dart
             │   │   └── all_destination_state.dart
             │   │
             │   ├── search_destination
             │   │   ├── seacrh_destination_bloc.dart
             │   │   ├── seacrh_destination_event.dart
             │   │   └── seacrh_destination_state.dart
             │   └── top_destination
             │       ├── top_destination_bloc.dart
             │       ├── top_destination_event.dart
             │       └── top_destination_state.dart
             ├── cubit
             │   └── dashboard_cubit.dart
             ├── pages
             │   ├── dashboard.dart
             │   ├── detail_destination_page.dart
             │   ├── get_all_destination_usecase.dart
             │   └── search_destination_usecase.dart
             └── widgets
                 ├── circle_loading.dart
                 ├── galery_photo.dart
                 ├── parallax_horiz_delegate.dart
                 ├── parallax_vert_delegate.dart
                 ├── text_failure.dart
                 └── top_destination_image.dart
               
```

<br />

<h3 align="center">Architecture Proposal</h3>

<br />

<img src="./architecture-proposal.png" style="display: block; margin-left: auto; margin-right: auto; width: 75%;"/>

<br />
<br />
