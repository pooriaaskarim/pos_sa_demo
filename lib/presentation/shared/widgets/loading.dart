import 'package:flutter/material.dart';

import '../../../infrastructure/utils/app.sizes.dart';
import '../../../infrastructure/utils/app.utils.dart';

class Loading extends StatelessWidget {
  const Loading({
    this.message,
    super.key,
  });

  final String? message;
  @override
  Widget build(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 2),
          if (message != null) ...[
            AppUtils.verticalSpacer(AppSizes.points_8),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      );
}
