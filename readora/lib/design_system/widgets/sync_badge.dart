import 'package:flutter/material.dart';
import 'package:readora/core/sync/sync_engine.dart';
import 'package:readora/core/sync/sync_status.dart';
import 'package:readora/design_system/tokens/readora_colors.dart';
import 'package:readora/design_system/tokens/readora_spacing.dart';

/// Small, honest indicator of where the user's data currently lives.
///
/// Being offline is NOT an error state in Readora — people read on planes and
/// in basements. The badge stays quiet when synced, and when offline it
/// reassures rather than warns.
class SyncBadge extends StatelessWidget {
  const SyncBadge({required this.engine, super.key});

  final SyncEngine engine;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SyncStatus>(
      stream: engine.status,
      initialData: engine.currentStatus,
      builder: (context, snapshot) {
        final status = snapshot.data ?? const SyncStatus();
        if (status.state == SyncState.synced && status.pending == 0) {
          return const SizedBox.shrink();
        }

        final (icon, color, text) = switch (status.state) {
          SyncState.syncing => (Icons.sync, ReadoraColors.brandSoft, 'Syncing'),
          SyncState.offline => (Icons.cloud_off_outlined, ReadoraColors.lightTextTertiary, 'Offline'),
          SyncState.failed => (Icons.cloud_queue, ReadoraColors.warning, 'Will retry'),
          SyncState.synced => (Icons.cloud_done_outlined, ReadoraColors.success, 'Saved'),
        };

        return Tooltip(
          message: status.pending > 0
              ? '${status.pending} change${status.pending == 1 ? '' : 's'} saved on this device'
              : 'Everything is saved',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: Spacing.xs),
                Text(text, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color)),
              ],
            ),
          ),
        );
      },
    );
  }
}
