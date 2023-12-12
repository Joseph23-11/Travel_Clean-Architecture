import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_course/features/destination/presentation/widgets/circle_loading.dart';
import 'package:travel_course/features/destination/presentation/widgets/paralax_vert_delegate.dart';

import '../../../../api/urls.dart';
import '../../../../common/app_route.dart';
import '../../domain/entities/destination_entity.dart';
import '../bloc/all_destination/all_destination_bloc.dart';
import '../bloc/search_destination/search_destination_bloc.dart';
import '../widgets/text_failure.dart';

class SearchDestinationPage extends StatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  State<SearchDestinationPage> createState() => _SearchDestinationPageState();
}

class _SearchDestinationPageState extends State<SearchDestinationPage> {
  final edtSearch = TextEditingController();
  late List<DestinationEntity> allDestinations;
  bool showCloseButton = false;

  @override
  void initState() {
    context.read<AllDestinationBloc>().add(OnGetAllDestination());
    context.read<SearchDestinationBloc>().add(OnResetSearchDestination());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    edtSearch.addListener(() {
      setState(() {
        showCloseButton = edtSearch.text.isNotEmpty;
      });
    });
  }

  search() {
    if (edtSearch.text == '') return;
    context
        .read<SearchDestinationBloc>()
        .add(OnSearchDestination(edtSearch.text));
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.only(
          top: 60,
          bottom: 80,
        ),
        child: buildSearch(),
      ),
      bottomSheet: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 140,
          child: BlocBuilder<SearchDestinationBloc, SearchDestinationState>(
            builder: (context, searchDestinationState) {
              if (searchDestinationState is SearchDestinationLoading) {
                return const CircleLoading();
              } else if (searchDestinationState is SearchDestinationFailure) {
                return TextFailure(message: searchDestinationState.message);
              } else if (searchDestinationState is SearchDestinationLoaded) {
                List<DestinationEntity> list = searchDestinationState.data;
                return ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    DestinationEntity destination = list[index];
                    return Container(
                      margin: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: index == 0 ? 24 : 10,
                        bottom: index == list.length - 1 ? 24 : 10,
                      ),
                      child: itemSearch(destination),
                    );
                  },
                );
              } else if (searchDestinationState is SearchDestinationInitial) {
                // Display all destinations initially
                return BlocBuilder<AllDestinationBloc, AllDestinationState>(
                  builder: (context, allDestinationState) {
                    if (allDestinationState is AllDestinationLoading) {
                      return const CircleLoading();
                    } else if (allDestinationState is AllDestinationFailure) {
                      return TextFailure(message: allDestinationState.message);
                    } else if (allDestinationState is AllDestinationLoaded) {
                      allDestinations = allDestinationState.data;
                      return ListView.builder(
                        itemCount: allDestinations.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          DestinationEntity destination =
                              allDestinations[index];
                          return Container(
                            margin: EdgeInsets.only(
                              left: 24,
                              right: 24,
                              top: index == 0 ? 24 : 10,
                              bottom:
                                  index == allDestinations.length - 1 ? 24 : 10,
                            ),
                            child: itemSearch(destination),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget itemSearch(DestinationEntity destination) {
    final imageKey = GlobalKey();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.detailDestination,
          arguments: destination,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AspectRatio(
          aspectRatio: 2,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Builder(builder: (context) {
                return Flow(
                  delegate: ParallaxVertDelegate(
                    scrollable: Scrollable.of(context),
                    listItemContext: context,
                    backgroundImageKey: imageKey,
                  ),
                  children: [
                    ExtendedImage.network(
                      URLs.image(destination.cover),
                      key: imageKey,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      handleLoadingProgress: true,
                      loadStateChanged: (state) {
                        if (state.extendedImageLoadState == LoadState.failed) {
                          return Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.black,
                            ),
                          );
                        }
                        if (state.extendedImageLoadState == LoadState.loading) {
                          return Material(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[300],
                            child: const CircleLoading(),
                          );
                        }
                        return null;
                      },
                    ),
                  ],
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                destination.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                destination.location,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: destination.rate,
                          allowHalfRating: true,
                          unratedColor: Colors.grey,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {},
                          itemSize: 15,
                          ignoreGestures: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          IconButton.filledTonal(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: edtSearch,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Search destination here...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Visibility(
                  visible: showCloseButton,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        edtSearch.clear();
                      });
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          IconButton.filledTonal(
            onPressed: () => search(),
            icon: const Icon(
              Icons.search,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
