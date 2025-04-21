package org.mohanned.calculatorcmpapp

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform