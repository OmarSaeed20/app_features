# DropMe Recycling App - ProGuard Configuration
# Optimized for Flutter, Firebase, and modern Android development
# Release mode only - no test configurations

# ===============================================
# FLUTTER CORE RULES
# ===============================================

# Flutter Engine
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Flutter Build Configuration
-keep class io.flutter.plugins.** { *; }

# Dart VM Service
-keep class io.flutter.plugins.firebase.messaging.** { *; }

# ===============================================
# APPLICATION SPECIFIC RULES
# ===============================================


# Main Application Package (update to match namespace)
-keep class com.example.drop_me.** { *; }
-keepclassmembers class com.example.drop_me.** { *; }

# Method Channel Handlers
-keep class * extends io.flutter.plugin.common.MethodCallHandler { *; }
-keep class * implements io.flutter.plugin.common.MethodCallHandler { *; }

# ===============================================
# FIREBASE RULES
# ===============================================

# Firebase Core
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Crashlytics
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# Firebase Performance
-keep class com.google.firebase.perf.** { *; }
-dontwarn com.google.firebase.perf.**

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.iid.** { *; }

# Firebase Analytics
-keep class com.google.firebase.analytics.** { *; }
-keep class com.google.android.gms.measurement.** { *; }

# ===============================================
# FACEBOOK SDK RULES
# ===============================================

-keep class com.facebook.** { *; }
-keepclassmembers class com.facebook.** { *; }
-keep interface com.facebook.** { *; }
-dontwarn com.facebook.**

# Facebook Login
-keep class com.facebook.login.** { *; }
-keep class com.facebook.share.** { *; }

# ===============================================
# GSON / JSON SERIALIZATION
# ===============================================

-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer


# Gson Models (adjusted to match namespace)
-keep class com.example.drop_me.models.** { <fields>; }
-keep class com.example.drop_me.data.** { <fields>; }

# ===============================================
# RETROFIT / OKHTTP RULES
# ===============================================

-keep class retrofit2.** { *; }
-keepclassmembers class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions

-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**


# Retrofit Interfaces (adjusted to match namespace)
-keep interface com.example.drop_me.api.** { *; }

# ===============================================
# KOTLIN RULES
# ===============================================

-keep class kotlin.** { *; }
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.**

# Kotlin Serialization
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt

# Kotlin Coroutines
-keep class kotlinx.coroutines.** { *; }
-keep class kotlinx.coroutines.android.** { *; }

# ===============================================
# ANDROIDX / ANDROID SUPPORT RULES
# ===============================================

-keep class androidx.** { *; }
-keep interface androidx.** { *; }
-dontwarn androidx.**

# ViewBinding
-keep class * implements androidx.viewbinding.ViewBinding { *; }

# Lifecycle
-keep class androidx.lifecycle.** { *; }
-keep interface androidx.lifecycle.** { *; }

# Navigation
-keep class androidx.navigation.** { *; }

# ===============================================
# GENERAL ANDROID RULES
# ===============================================

# Preserve Activity classes
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Enum support
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Parcelable implementations
-keepclassmembers class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

# Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# ===============================================
# ANNOTATION PRESERVATION
# ===============================================

-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod
-keepattributes SourceFile
-keepattributes LineNumberTable

# ===============================================
# REFLECTION RULES
# ===============================================

# Keep classes that use reflection
-keepattributes *Annotation*
-keep class * {
    @androidx.annotation.Keep *;
}

# ===============================================
# OPTIMIZATION SETTINGS - RELEASE ONLY
# ===============================================

# Enable aggressive optimizations
-optimizations !code/simplification/arithmetic,!field/,!class/merging/,!code/allocation/variable
-optimizationpasses 5
-allowaccessmodification
-dontpreverify

# ===============================================
# WARNING SUPPRESSIONS
# ===============================================

-dontwarn com.google.**
-dontwarn com.facebook.**
-dontwarn androidx.**
-dontwarn kotlin.**
-dontwarn retrofit2.**
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn j$.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**

# ===============================================
# DEBUG INFORMATION - RELEASE ONLY
# ===============================================

# Keep source file names for better crash reports
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Print usage information
-printusage build/outputs/mapping/release/usage.txt

# Print mapping information
-printmapping build/outputs/mapping/release/mapping.txt