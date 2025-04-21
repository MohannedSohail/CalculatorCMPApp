# 1. استخدم صورة JDK مناسبة
FROM openjdk:17-jdk

# 2. تثبيت الأدوات الأساسية
RUN apt-get update && apt-get install -y wget unzip git

# 3. إعداد Android SDK
ENV ANDROID_SDK_ROOT /opt/android-sdk
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools

WORKDIR $ANDROID_SDK_ROOT/cmdline-tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O tools.zip \
  && unzip tools.zip \
  && mv cmdline-tools latest \
  && rm tools.zip

ENV PATH="${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools"

# 4. قبول التراخيص وتحميل الأدوات المطلوبة
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# 5. إعداد مجلد المشروع
WORKDIR /app
COPY . /app

# 6. تنفيذ أمر البناء
CMD ["./gradlew", "assembleDebug"]
