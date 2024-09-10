import 'package:flutter/material.dart';

class InfiniteListViewWidget extends StatefulWidget {
  final int pageSize;
  final List<Widget> children;
  const InfiniteListViewWidget({
    super.key,
    required this.pageSize,
    required this.children,
  });

  @override
  State<InfiniteListViewWidget> createState() => _InfiniteListViewWidgetState();
}

class _InfiniteListViewWidgetState extends State<InfiniteListViewWidget> {
  late final int pageSize;
  late final ScrollController scrollController;
  late final List<Widget> children;
  late final bool fullCharging;

  @override
  void initState() {
    super.initState();
    pageSize = pageSize;

    fullCharging = pageSize >= widget.children.length;

    scrollController = ScrollController();

    children = widget.children;

    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          loadMore();
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        controller: scrollController,
        itemCount: children.length + (fullCharging ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == children.length) {
            return const Center(child: CircularProgressIndicator());
          }

          return children[index];
        },
      );

  void loadMore() {
    int nextPage = children.length + pageSize;
    if (nextPage > widget.children.length) {
      nextPage = widget.children.length;
    }

    final List<Widget> nextChildren =
        widget.children.sublist(children.length, nextPage);
    children.addAll(nextChildren);
    setState(() {});
  }
}
