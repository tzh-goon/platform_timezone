package com.tzhgoon.platform_timezone

import android.content.Context

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.toCollection

class PlatformTimezonePlugin : MethodCallHandler {

    var channel: MethodChannel? = null

    companion object {
        /** Plugin registration.  */
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = PlatformTimezonePlugin()
            plugin.setupMethodChannel(registrar.messenger(), registrar.context())
        }
    }


    fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        setupMethodChannel(binding.getBinaryMessenger(), binding.getApplicationContext())
    }

    fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding?) {
        tearDownChannel()
    }

    private fun setupMethodChannel(messenger: BinaryMessenger, context: Context) {
        channel = MethodChannel(messenger, "platform_timezone")
        channel!!.setMethodCallHandler(this)
    }

    private fun tearDownChannel() {
        channel!!.setMethodCallHandler(null)
        channel = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getLocalTimezone" -> {
                result.success(TimeZone.getDefault().id)
            }
            "getAvailableTimezones" -> {
                result.success(TimeZone.getAvailableIDs().toCollection(ArrayList()))
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
