package com.example.azure_speech_recognition_services

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.mockito.Mockito
import kotlin.test.Test

internal class AzureSpeechRecognitionServicesPluginTest {
    @Test
    fun onMethodCall_isContinuousRecognitionOn_returnsFalseByDefault() {
        val plugin = AzureSpeechRecognitionServicesPlugin()

        val call = MethodCall("isContinuousRecognitionOn", null)
        val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)
        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).success(false)
    }
}
