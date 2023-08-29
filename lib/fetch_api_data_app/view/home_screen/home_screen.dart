import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/fetch_api_data_app/post_state/post_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Training'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              ref.read(postNotifierProvider.notifier).fetchData();
            },
            child: const Icon(Icons.add)),
        body: Consumer(
          builder: (context, ref, child) {
            PostState state = ref.watch(postNotifierProvider);
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.posts[index].title),
                      subtitle: Text(state.posts[index].body),
                    );
                  });
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
