package com.example.music_home

import android.app.KeyguardManager
import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val manager = this.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            manager.requestDismissKeyguard(this, null)
        } else {
            val lock = manager.newKeyguardLock("music_home")
            lock.disableKeyguard()
        }
    }
}

