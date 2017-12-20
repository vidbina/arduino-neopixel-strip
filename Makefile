ARDUINO-BUILDER=arduino-builder
AVRDUDE=avrdude
STTY=stty

MKDIR=mkdir -p
RM=rm -rf

BUILD_DIR=${PWD}/out

ARDUINO_FQBN?=arduino:avr:mega:cpu=atmega2560
ARDUINO_SKETCH?=Simple.sketch.cpp

AVRDUDE_DEVICE?=m2560
AVRDUDE_PROGRAMMER?=stk500v2
AVRDUDE_BAUDRATE?=115200
AVRDUDE_PORT?=/dev/ttyACM0


build:
	${MKDIR} ${BUILD_DIR}
	${ARDUINO-BUILDER} \
		-build-path ${BUILD_DIR} \
		-debug-level 10 \
		-fqbn ${ARDUINO_FQBN} \
		-hardware ${ARDUINO_PATH}/share/arduino/hardware/ \
		-libraries ${ARDUINO_PATH}/share/arduino/libraries/ \
		-tools ${ARDUINO_PATH}/share/arduino/tools/ \
		-tools ${ARDUINO_PATH}/share/arduino/tools-builder/ \
		-tools ${ARDUINO_PATH}/share/arduino/hardware/tools/ \
		-verbose \
		-warnings all \
		${ARDUINO_SKETCH}

clean:
	${RM} ${BUILD_DIR}

flash:
	${AVRDUDE} \
		-C${ARDUINO_PATH}/share/arduino/hardware/tools/avr/etc/avrdude.conf \
		-p${AVRDUDE_DEVICE} \
		-c${AVRDUDE_PROGRAMMER} \
		-v -v -v -v \
		-P${AVRDUDE_PORT} \
		-b${AVRDUDE_BAUDRATE} \
		-D \
		-Uflash:w:${PWD}/out/${ARDUINO_SKETCH}.hex:i

.PHONY: build clean flash
