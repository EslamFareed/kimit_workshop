import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kimit_workshop/cubits/news/news_cubit.dart';
import 'package:kimit_workshop/screens/news_details_screen.dart';
import 'package:kimit_workshop/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = NewsCubit.get(context);
    cubit.getData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ));
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          return state is LoadingNews
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                  item:
                                      cubit.newsReponseModel!.articles![index]),
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                height: MediaQuery.sizeOf(context).height *
                                    0.6 *
                                    .1,
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgUNaoFwOOa3sOnMoc8CVUJ65bhS822etxVQ&usqp=CAU"),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  .5,
                                          child: Text(
                                            cubit.newsReponseModel!
                                                    .articles![index].author ??
                                                "UnKnown",
                                            maxLines: 1,
                                          ),
                                        ),
                                        Text(
                                          cubit.newsReponseModel!
                                              .articles![index].publishedAt!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                height: MediaQuery.sizeOf(context).height *
                                    0.6 *
                                    .1,
                                child: Text(
                                  cubit.newsReponseModel!.articles![index]
                                      .title!,
                                ),
                              ),
                              Expanded(
                                child: Hero(
                                  tag: cubit.newsReponseModel!.articles![index]
                                      .urlToImage!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(cubit
                                            .newsReponseModel!
                                            .articles![index]
                                            .urlToImage!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: cubit.newsReponseModel!.articles!.length,
                );
        },
      ),
    );
  }
}
