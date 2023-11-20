part of home;

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Column(
      children: [
        TabBar(
          padding: EdgeInsets.zero,
          isScrollable: false,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: tabController,
          tabs: const [
            Tab(
              text: 'Notifications',
            ),
            Tab(
              text: 'Map',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const [
              NotificationsTab(),
              MapTab(),
            ],
          ),
        ),
      ],
    );
  }
}
