package com.example.theme_and_contrast

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.accessibility/contrast"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "isHighContrastEnabled") {
                try {
                    // Try multiple approaches to detect high contrast
                    var enabled = false
                    var methodUsed = "none"

                    // Method 1: Check for high contrast text setting (Android 4.2+)
                    try {
                        val highContrastText =
                                Settings.Secure.getInt(
                                        contentResolver,
                                        "accessibility_high_text_contrast_enabled"
                                )
                        enabled = highContrastText == 1
                        methodUsed = "high_contrast_text"
                        android.util.Log.d(
                                "ContrastDebug",
                                "Method 1 - high_contrast_text: $enabled"
                        )
                    } catch (e: Settings.SettingNotFoundException) {
                        android.util.Log.d("ContrastDebug", "Method 1 failed: ${e.message}")

                        // Method 2: Check for accessibility enabled setting
                        try {
                            val accessibilityEnabled =
                                    Settings.Secure.getInt(contentResolver, "accessibility_enabled")
                            enabled = accessibilityEnabled == 1
                            methodUsed = "accessibility_enabled"
                            android.util.Log.d(
                                    "ContrastDebug",
                                    "Method 2 - accessibility_enabled: $enabled"
                            )
                        } catch (e2: Settings.SettingNotFoundException) {
                            android.util.Log.d("ContrastDebug", "Method 2 failed: ${e2.message}")

                            // Method 3: Check for font scale (indirect indicator)
                            try {
                                val fontScale =
                                        Settings.Secure.getFloat(contentResolver, "font_scale")
                                // If font scale is significantly different from 1.0, might indicate
                                // accessibility
                                enabled = fontScale > 1.2f
                                methodUsed = "font_scale"
                                android.util.Log.d(
                                        "ContrastDebug",
                                        "Method 3 - font_scale: $fontScale, enabled: $enabled"
                                )
                            } catch (e3: Settings.SettingNotFoundException) {
                                android.util.Log.d(
                                        "ContrastDebug",
                                        "Method 3 failed: ${e3.message}"
                                )
                                enabled = false
                                methodUsed = "none"
                            }
                        }
                    }

                    // Try additional methods for newer Android versions
                    try {
                        val highContrastEnabled =
                                Settings.Secure.getInt(
                                        contentResolver,
                                        "high_text_contrast_enabled"
                                )
                        if (highContrastEnabled == 1) {
                            enabled = true
                            methodUsed = "high_text_contrast_enabled"
                            android.util.Log.d(
                                    "ContrastDebug",
                                    "Additional method - high_text_contrast_enabled: true"
                            )
                        }
                    } catch (e: Settings.SettingNotFoundException) {
                        android.util.Log.d(
                                "ContrastDebug",
                                "Additional method failed: ${e.message}"
                        )
                    }

                    android.util.Log.d(
                            "ContrastDebug",
                            "Final result: $enabled (method: $methodUsed)"
                    )
                    result.success(enabled)
                } catch (e: Exception) {
                    result.error(
                            "UNAVAILABLE",
                            "Failed to get contrast setting: ${e.message}",
                            null
                    )
                }
            } else if (call.method == "listAccessibilitySettings") {
                try {
                    val cursor =
                            contentResolver.query(
                                    Settings.Secure.CONTENT_URI,
                                    null,
                                    null,
                                    null,
                                    null
                            )

                    val settings = mutableListOf<String>()
                    cursor?.use {
                        while (it.moveToNext()) {
                            val nameIndex = it.getColumnIndex(Settings.Secure.NAME)
                            val valueIndex = it.getColumnIndex(Settings.Secure.VALUE)
                            if (nameIndex >= 0 && valueIndex >= 0) {
                                val name = it.getString(nameIndex)
                                val value = it.getString(valueIndex)
                                if (name?.contains("accessibility", ignoreCase = true) == true ||
                                                name?.contains("contrast", ignoreCase = true) ==
                                                        true ||
                                                name?.contains("font", ignoreCase = true) == true
                                ) {
                                    settings.add("$name = $value")
                                }
                            }
                        }
                    }

                    android.util.Log.d(
                            "ContrastDebug",
                            "Available accessibility settings: ${settings.joinToString(", ")}"
                    )
                    result.success(settings)
                } catch (e: Exception) {
                    android.util.Log.e("ContrastDebug", "Failed to list settings: ${e.message}")
                    result.error("ERROR", "Failed to list settings: ${e.message}", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
