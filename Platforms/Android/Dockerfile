FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
  libpulse0 \
  pulseaudio \ 
  openjdk-17-jdk \
  libglu1-mesa \
  wget \
  unzip

RUN mkdir -p android-sdk/cmdline-tools/latest

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /cmdline-tools.zip
RUN unzip /cmdline-tools.zip
RUN mv /cmdline-tools/* /android-sdk/cmdline-tools/latest
RUN rm -rf /cmdline-tools.zip /cmdline-tools

RUN wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip -O /platform-tools.zip
RUN unzip /platform-tools.zip -d /android-sdk
RUN rm /platform-tools.zip

ENV ANDROID_SDK_ROOT=/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
ENV PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
ENV PATH=$PATH:$ANDROID_SDK_ROOT/emulator

RUN yes | sdkmanager --install "build-tools;31.0.0" "platforms;android-31" "system-images;android-31;google_apis;x86_64"
RUN yes | sdkmanager --licenses
RUN echo "no" | avdmanager create avd -n EmulatorDevice -k "system-images;android-31;google_apis;x86_64"

CMD ["emulator", "-avd", "EmulatorDevice"]
