package com.example.base_flutter_app;

import java.io.PrintStream;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.EventChannel;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

public class TestPlugin implements  FlutterPlugin,MethodChannel.MethodCallHandler{

    private final static String testChannelName = "testChannelName";
    private MethodChannel _channel ;

    @Override
    public void onAttachedToEngine( FlutterPluginBinding binding) {
        //主要通过MethodChannel来跟Flutter交互
        _channel = new MethodChannel(binding.getBinaryMessenger(), testChannelName);
        _channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine( FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

        System.out.println("Flutter 调用方法：method" + methodCall.method);
        System.out.println("Flutter 调用方法：arguments" + methodCall.arguments);
    }
}

