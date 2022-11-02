import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/news_cubit.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Haberler'),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: ((context, state) {
            if (state is NewsInitial) {
              return const SizedBox();
            } else if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.articles.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ClipRRect(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            width: 400,
                            height: 200,
                            child: Image.network(
                              state.response.articles[index].urlToImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  '${state.response.articles[index].content}...')),
                          Text(
                              ' Yazar : ${state.response.articles[index].author}...'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              final error = state as NewsError;
              return Text(error.message);
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() => context.read<NewsCubit>().GetNews()),
          child: const Icon(Icons.add),
        ));
  }
}
