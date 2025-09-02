import groovy.json.JsonSlurper
import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Utility functions for better configuration management
fun loadProperties(path: String): Properties {
    val properties = Properties()
    val file = rootProject.file(path)
    if (file.exists()) {
        file.inputStream().use { properties.load(it) }
    } else {
        logger.warn("Properties file not found: $path")
    }
    return properties
}

// Function to load JSON config
fun loadJsonConfig(flavor: String): Map<String, Any> {
    val file = rootProject.file("../.env/${flavor}.json")
    if (file.exists()) {
        val jsonText = file.readText()
        return JsonSlurper().parseText(jsonText) as Map<String, Any>
    } else {
        logger.warn("JSON config file not found: ../.env/${flavor}.json")
        return emptyMap()
    }
}

// Load keystore properties
val keystoreProperties = loadProperties("key.properties")

android {
    namespace = "com.example.drop_me"
    compileSdk = 34
    ndkVersion = "27.0.12077973"
    
    buildFeatures.buildConfig = true
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.drop_me"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName
        
        multiDexEnabled = true
        vectorDrawables.useSupportLibrary = true
        
        ndk {
            abiFilters.addAll(listOf("arm64-v8a", "armeabi-v7a"))
        }
    }

    flavorDimensions.add("environment")

    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            
            val config = loadJsonConfig("dev")
            manifestPlaceholders["google_maps_api_key"] = config["MAPS_API_KEY"] ?: ""
            manifestPlaceholders["facebook_app_id"] = config["FACEBOOK_APP_ID"] ?: ""
            manifestPlaceholders["facebook_client_token"] = config["FACEBOOK_CLIENT_TOKEN"] ?: ""
            
            buildConfigField("String", "API_BASE_URL", "\"${config["API_BASE_URL"] ?: ""}\"")
            buildConfigField("String", "ENVIRONMENT", "\"dev\"")
            resValue("string", "app_name", config["APP_NAME"]?.toString() ?: "App Feature Dev")
        }
        
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
            
            val config = loadJsonConfig("staging")
            manifestPlaceholders["google_maps_api_key"] = config["MAPS_API_KEY"] ?: ""
            manifestPlaceholders["facebook_app_id"] = config["FACEBOOK_APP_ID"] ?: ""
            manifestPlaceholders["facebook_client_token"] = config["FACEBOOK_CLIENT_TOKEN"] ?: ""
            
            buildConfigField("String", "API_BASE_URL", "\"${config["API_BASE_URL"] ?: ""}\"")
            buildConfigField("String", "ENVIRONMENT", "\"staging\"")
            resValue("string", "app_name", config["APP_NAME"]?.toString() ?: "App Feature Staging")
        }
        
        create("prod") {
            dimension = "environment"
            
            val config = loadJsonConfig("prod")
            manifestPlaceholders["google_maps_api_key"] = config["MAPS_API_KEY"] ?: ""
            manifestPlaceholders["facebook_app_id"] = config["FACEBOOK_APP_ID"] ?: ""
            manifestPlaceholders["facebook_client_token"] = config["FACEBOOK_CLIENT_TOKEN"] ?: ""
            
            buildConfigField("String", "API_BASE_URL", "\"${config["API_BASE_URL"] ?: ""}\"")
            buildConfigField("String", "ENVIRONMENT", "\"production\"")
            resValue("string", "app_name", config["APP_NAME"]?.toString() ?: "App Feature")
        }
    }
    
    signingConfigs {
        create("release") {
            val keyAlias = keystoreProperties.getProperty("keyAlias")
            if (keyAlias != null) {
                this.keyAlias = keyAlias
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            } else {
                logger.warn("Release signing configuration not found, using debug")
                // *Fallback to debug signing
                // this.keyAlias = "androiddebugkey"
                // this.keyPassword = "android"
                // this.storeFile = rootProject.file("${System.getProperty("user.home")}/.android/debug.keystore")
                // this.storePassword = "android"
            }
        }
    }
    
    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            isDebuggable = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
            isDebuggable = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.1.10")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    implementation("androidx.multidex:multidex:2.0.1")
    implementation(platform("com.google.firebase:firebase-bom:34.2.0"))
}