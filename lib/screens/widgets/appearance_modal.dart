import 'package:flutter/material.dart';
import 'package:theme_and_contrast/core/theme/manager/theme_manager.dart';

class AppearanceModal extends StatefulWidget {
  const AppearanceModal({super.key});

  @override
  State<AppearanceModal> createState() => _AppearanceModalState();
}

class _AppearanceModalState extends State<AppearanceModal> {
  @override
  void initState() {
    super.initState();
    // Listen to theme changes
    ThemeManager.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    // Remove listener when widget is disposed
    ThemeManager.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {
      // Rebuild the widget when theme changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeMode = ThemeManager.themeMode;
    final contrastMode = ThemeManager.contrastMode;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Theme'),
                  const SizedBox(height: 16),
                  _buildThemeOptions(context, themeMode),
                  const SizedBox(height: 32),
                  _buildSectionTitle(context, 'Contrast'),
                  const SizedBox(height: 16),
                  _buildContrastOptions(context, contrastMode),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildThemeOptions(BuildContext context, ThemeMode themeMode) {
    return Row(
      children: [
        Expanded(
          child: _buildThemeCard(context, ThemeMode.light, 'Light', themeMode),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildThemeCard(context, ThemeMode.dark, 'Dark', themeMode),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildThemeCard(
            context,
            ThemeMode.system,
            'System',
            themeMode,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    ThemeMode target,
    String title,
    ThemeMode currentThemeMode,
  ) {
    final isSelected = currentThemeMode == target;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        ThemeManager.setThemeMode(target);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            _buildThemePreview(target),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? colorScheme.onPrimaryContainer : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemePreview(ThemeMode target) {
    if (target == ThemeMode.system) {
      return Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final isDark = target == ThemeMode.dark;
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[600] : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[600] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContrastOptions(
    BuildContext context,
    ContrastMode contrastMode,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildContrastCard(
            context,
            ContrastMode.normal,
            'Normal',
            contrastMode,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildContrastCard(
            context,
            ContrastMode.high,
            'High',
            contrastMode,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildContrastCard(
            context,
            ContrastMode.system,
            'System',
            contrastMode,
          ),
        ),
      ],
    );
  }

  Widget _buildContrastCard(
    BuildContext context,
    ContrastMode target,
    String title,
    ContrastMode currentContrastMode,
  ) {
    final isSelected = currentContrastMode == target;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        ThemeManager.setContrastMode(target);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            _buildContrastPreview(context, target),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? colorScheme.onPrimaryContainer : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContrastPreview(BuildContext context, ContrastMode target) {
    final isHighContrast =
        target == ContrastMode.high ||
        (target == ContrastMode.system && MediaQuery.of(context).highContrast);
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: isHighContrast ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isHighContrast ? Colors.white : Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.contrast,
                size: 12,
                color: isHighContrast ? Colors.black : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: isHighContrast ? Colors.white : Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 30,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isHighContrast ? Colors.white : Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
