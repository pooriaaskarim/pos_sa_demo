part of home;

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(final BuildContext context) => SliverPersistentHeader(
        delegate: HomeHeaderDelegate(),
        pinned: true,
        floating: true,
      );
}

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    final BuildContext context,
    final double shrinkOffset,
    final bool overlapsContent,
  ) {
    final themeData = Theme.of(context);

    final titleStyle = themeData.textTheme.displaySmall;
    final titleSize =
        titleStyle!.fontSize! * ((maxExtent - shrinkOffset) / maxExtent);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.points_8),
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        border: Border(
          bottom: BorderSide(color: themeData.colorScheme.primary, width: .5),
        ),
      ),
      child: Padding(
        padding: AppUtils.responsiveHorizontalPadding(context).add(
          const EdgeInsets.only(
            top: AppSizes.points_12,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildTitle(titleStyle, themeData, titleSize),
                ),
              ],
            ),
            const Positioned(
              right: AppSizes.points_12,
              top: AppSizes.points_12,
              child: ThemeToggleButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(
    final TextStyle titleStyle,
    final ThemeData themeData,
    final double titleSize,
  ) =>
      Text(
        "Demo",
        style: titleStyle.copyWith(
          color: themeData.colorScheme.primary,
          fontSize:
              titleSize >= AppSizes.points_24 ? titleSize : AppSizes.points_24,
        ),
      );

  @override
  double get maxExtent => AppSizes.points_64 * 2;

  @override
  double get minExtent => AppSizes.points_64 * 1.6;

  @override
  bool shouldRebuild(
    covariant final SliverPersistentHeaderDelegate oldDelegate,
  ) =>
      true;
}
