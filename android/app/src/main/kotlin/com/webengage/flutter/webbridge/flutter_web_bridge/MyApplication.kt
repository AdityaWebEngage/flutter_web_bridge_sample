package com.webengage.flutter.webbridge.flutter_web_bridge

import com.webengage.sdk.android.WebEngage
import com.webengage.sdk.android.WebEngageConfig
import com.webengage.webengage_plugin.WebengageInitializer
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        val weConfig = WebEngageConfig.Builder()
            .setWebEngageKey("~2024bb40")
            .setDebugMode(true)
            .build()
        WebengageInitializer.initialize(this,weConfig)
    }
}