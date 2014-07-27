classdef VernierDictionary

properties (Constant)
%*******************************
% Constants from "GVernierUSB.h"
%*******************************

VERNIER_DEFAULT_VENDOR_ID  = hex2dec('08F7');

LABPRO_DEFAULT_PRODUCT_ID = hex2dec('0001');
USB_DIRECT_TEMP_DEFAULT_PRODUCT_ID = hex2dec('0002');	%aka GoTemp
SKIP_DEFAULT_PRODUCT_ID = hex2dec('0003');				%aka GoLink
CYCLOPS_DEFAULT_PRODUCT_ID = hex2dec('0004');			%aka GoMotion
NGI_DEFAULT_PRODUCT_ID = hex2dec('0005');				%aka LabQuest
LOWCOST_SPEC_DEFAULT_PRODUCT_ID = hex2dec('0006');		%aka SpectroVis
MINI_GC_DEFAULT_PRODUCT_ID = hex2dec('0007');			%aka Vernier Mini Gas Chromatograph
STANDALONE_DAQ_DEFAULT_PRODUCT_ID = hex2dec('0008');	%aka LabQuest Mini
LOWCOST_SPEC2_DEFAULT_PRODUCT_ID = hex2dec('0009');		%aka SpectroVis Plus


LABQUEST_DEFAULT_PRODUCT_ID = hex2dec('0005'); %NGI_DEFAULT_PRODUCT_ID;
LABQUEST_MINI_PRODUCT_ID = hex2dec('0008');%STANDALONE_DAQ_DEFAULT_PRODUCT_ID;
MINIGC_DEFAULT_PRODUCT_ID = hex2dec('0007');%MINI_GC_DEFAULT_PRODUCT_ID;

%// @brief What we thought was the unique Ohaus Scout Pro VID/PID is actually the FTDI generic VID/PID, which is also used by Watt's Up devices. This throws a big doo-doo in how we go about identifying and enumerating new devices on the bus. 
%// @see "GFTDIDevice.h"
FTDI_GENERIC_VENDOR_ID  = hex2dec('0403');
FTDI_GENERIC_PRODUCT_ID = hex2dec('6001');

OCEAN_OPTICS_DEFAULT_VENDOR_ID  = hex2dec('2457');
OCEAN_OPTICS_DEFAULT_PRODUCT_ID = hex2dec('1002');	% USB2000
OCEAN_OPTICS_USB325_PRODUCT_ID  = hex2dec('1024');
OCEAN_OPTICS_USB650_PRODUCT_ID  = hex2dec('1014');
OCEAN_OPTICS_USB2000_PRODUCT_ID = hex2dec('1002');
OCEAN_OPTICS_HR4000_PRODUCT_ID  = hex2dec('1012');
OCEAN_OPTICS_USB4000_PRODUCT_ID = hex2dec('1022');

%// FIX THIS!
NATIONAL_INSTRUMENTS_DEFAULT_VENDOR_ID  = hex2dec('3923');
SENSORDAQ_DEFAULT_PRODUCT_ID = hex2dec('72CC');


%*******************************
% Constants from "GoIO_DLL_interface.h"
%*******************************
GOIO_MAX_SIZE_DEVICE_NAME = ismac*255 + (~ismac)*260;
SKIP_TIMEOUT_MS_DEFAULT = 2000;
SKIP_TIMEOUT_MS_READ_DDSMEMBLOCK = 2000;
SKIP_TIMEOUT_MS_WRITE_DDSMEMBLOCK = 4000;


%*******************************
% Constants from "GSkipCommExt.h"
%*******************************

%/***************************************************************************************************/
%// Go! Link is also known as Skip.
%// Go! Temp is also known as Jonah.
%// Go! Motion is also known as Cyclops.
%//
%// This file contains declarations for parameter and response structures used by the Skip support
%// function SendCmdAndGetResponse().
%//
%// Skip, Jonah, and Cyclops use the same basic protocol. Not all commands are supported by all devices.
%// If a command is not supported, then SendCmdAndGetResponse() will fail and return -1.
%//
%/***************************************************************************************************/

%//
%// The currently defined commands are:
%//
SKIP_CMD_ID_GET_STATUS = hex2dec('10');
SKIP_CMD_ID_WRITE_LOCAL_NV_MEM_1BYTE = hex2dec('11');
SKIP_CMD_ID_WRITE_LOCAL_NV_MEM_2BYTES = hex2dec('12');
SKIP_CMD_ID_WRITE_LOCAL_NV_MEM_3BYTES = hex2dec('13');
SKIP_CMD_ID_WRITE_LOCAL_NV_MEM_4BYTES = hex2dec('14');
SKIP_CMD_ID_WRITE_LOCAL_NV_MEM_5BYTES = hex2dec('15');
SKIP_CMD_ID_WRITE_LOCAL_NV_MEM_6BYTES = hex2dec('16');
SKIP_CMD_ID_READ_LOCAL_NV_MEM = hex2dec('17');
SKIP_CMD_ID_START_MEASUREMENTS = hex2dec('18');
SKIP_CMD_ID_STOP_MEASUREMENTS = hex2dec('19');
SKIP_CMD_ID_INIT = hex2dec('1A');
SKIP_CMD_ID_SET_MEASUREMENT_PERIOD = hex2dec('1B');
SKIP_CMD_ID_GET_MEASUREMENT_PERIOD = hex2dec('1C');
SKIP_CMD_ID_SET_LED_STATE = hex2dec('1D');
SKIP_CMD_ID_GET_LED_STATE = hex2dec('1E');
SKIP_CMD_ID_GET_SERIAL_NUMBER = hex2dec('20');
%//Commands defined above are supported by Skip, Jonah, and Cyclops, except that Cyclops does not support the serial # or the NV_MEM cmds.
%//Skip extensions:
SKIP_CMD_ID_SET_VIN_OFFSET_DAC = hex2dec('1F');
SKIP_CMD_ID_WRITE_REMOTE_NV_MEM_1BYTE = hex2dec('21');
SKIP_CMD_ID_WRITE_REMOTE_NV_MEM_2BYTES = hex2dec('22');
SKIP_CMD_ID_WRITE_REMOTE_NV_MEM_3BYTES = hex2dec('23');
SKIP_CMD_ID_WRITE_REMOTE_NV_MEM_4BYTES = hex2dec('24');
SKIP_CMD_ID_WRITE_REMOTE_NV_MEM_5BYTES = hex2dec('25');
SKIP_CMD_ID_WRITE_REMOTE_NV_MEM_6BYTES = hex2dec('26');
SKIP_CMD_ID_READ_REMOTE_NV_MEM = hex2dec('27');
SKIP_CMD_ID_GET_SENSOR_ID = hex2dec('28');
SKIP_CMD_ID_SET_ANALOG_INPUT_CHANNEL = hex2dec('29');
SKIP_CMD_ID_GET_ANALOG_INPUT_CHANNEL = hex2dec('2A');
SKIP_CMD_ID_GET_VIN_OFFSET_DAC = hex2dec('2B');
SKIP_CMD_ID_SPARE1 = hex2dec('2C');
SKIP_CMD_ID_SPARE2 = hex2dec('2D');
SKIP_CMD_ID_SPARE3 = hex2dec('2E');
SKIP_CMD_ID_SPARE4 = hex2dec('2F');
FIRST_SKIP_CMD_ID = hex2dec('10');%SKIP_CMD_ID_GET_STATUS;
LAST_SKIP_CMD_ID = hex2dec('2F');%SKIP_CMD_ID_SPARE4;

%//
%/***************************************************************************************************/
%//

%// The structures below define the parameter and response blocks associated with the commands defined above.
%// Pointers to these structures are passed in to SendCmdAndGetResponse().
%// If no parameter structure is defined for a command, then the command does not take parameters.
%// If no response structure is defined for a command, then the only response associated with the command is GoIODefaultCmdResponse.
%// The exceptions to this rule are the SKIP_CMD_ID_READ_* commands, whose responses are simply byte arrays.

SKIP_STATUS_SUCCESS = hex2dec('0');
SKIP_STATUS_NOT_READY_FOR_NEW_CMD = hex2dec('30');
SKIP_STATUS_CMD_NOT_SUPPORTED = hex2dec('31');
SKIP_STATUS_INTERNAL_ERROR1 = hex2dec('32');
SKIP_STATUS_INTERNAL_ERROR2 = hex2dec('33');
SKIP_STATUS_ERROR_CANNOT_CHANGE_PERIOD_WHILE_COLLECTING = hex2dec('34');
SKIP_STATUS_ERROR_CANNOT_READ_NV_MEM_BLK_WHILE_COLLECTING_FAST = hex2dec('35');
SKIP_STATUS_ERROR_INVALID_PARAMETER = hex2dec('36');
SKIP_STATUS_ERROR_CANNOT_WRITE_FLASH_WHILE_COLLECTING = hex2dec('37');
SKIP_STATUS_ERROR_CANNOT_WRITE_FLASH_WHILE_HOST_FIFO_BUSY = hex2dec('38');
SKIP_STATUS_ERROR_OP_BLOCKED_WHILE_COLLECTING = hex2dec('39');
SKIP_STATUS_ERROR_CALCULATOR_CANNOT_MEASURE_WITH_NO_BATTERIES = hex2dec('3A');
SKIP_STATUS_ERROR_SLAVE_POWERUP_INIT = hex2dec('40');
SKIP_STATUS_ERROR_SLAVE_POWERRESTORE_INIT = hex2dec('41');
SKIP_STATUS_ERROR_COMMUNICATION = hex2dec('F0');


% /***************************************************************************************************/
% // Some redundant LED declarations:
SKIP_LED_COLOR_BLACK = uint8(hex2dec('C0'));
SKIP_LED_COLOR_RED = uint8(hex2dec('40'));
SKIP_LED_COLOR_GREEN = uint8(hex2dec('80'));
SKIP_LED_COLOR_RED_GREEN = uint8(hex2dec('0'));
SKIP_LED_BRIGHTNESS_MIN = uint8(hex2dec('0'));
SKIP_LED_BRIGHTNESS_MAX = uint8(hex2dec('10'));


kLEDOff = uint8(hex2dec('C0'));%SKIP_LED_COLOR_BLACK;
kLEDRed = uint8(hex2dec('40'));%SKIP_LED_COLOR_RED;
kLEDGreen = uint8(hex2dec('80'));%SKIP_LED_COLOR_GREEN;
kLEDOrange = uint8(hex2dec('0'));%SKIP_LED_COLOR_RED_GREEN;
kSkipMaxLedBrightness = uint8(hex2dec('10'));%SKIP_LED_BRIGHTNESS_MAX;
kSkipOrangeLedBrightness = uint8(hex2dec('4'));


%/***************************************************************************************************/

SKIP_ANALOG_INPUT_CHANNEL_VOFF = hex2dec('0');
SKIP_ANALOG_INPUT_CHANNEL_VIN  = hex2dec('1');
SKIP_ANALOG_INPUT_CHANNEL_VIN_LOW = hex2dec('2');
SKIP_ANALOG_INPUT_CHANNEL_VID  = hex2dec('3');
%//
%//SKIP_ANALOG_INPUT_CHANNEL_VIN is used for +/- 10 volt probes.
%//SKIP_ANALOG_INPUT_CHANNEL_VIN_LOW is used for 5 volt probes.
%//


%/***************************************************************************************************/
%//The following bits are used by all Go! devices:
SKIP_MASK_STATUS_ERROR_CMD_NOT_RECOGNIZED = hex2dec('1');
SKIP_MASK_STATUS_ERROR_CMD_IGNORED = hex2dec('2');
SKIP_MASK_STATUS_ERROR_MASTER_FIFO_OVERFLOW = hex2dec('40');

%//The following bits are used by Skip only:
SKIP_MASK_STATUS_ERROR_PACKET_OVERRUN = hex2dec('4');
SKIP_MASK_STATUS_ERROR_MEAS_PACKET_LOST = hex2dec('8');
SKIP_MASK_STATUS_ERROR_MASTER_INVALID_SPI_PACKET = hex2dec('10');
SKIP_MASK_STATUS_ERROR_MASTER_INVALID_MEAS_COUNTER = hex2dec('20');
SKIP_MASK_STATUS_ERROR_MEAS_CONVERSION_LOST = hex2dec('80');

%//The following bits are used by Cyclops only:
%//((system_status & SKIP_MASK_STATUS_BATTERY_STATE) == SKIP_MASK_STATUS_BATTERY_STATE_GOOD) => good batteries.
%//((system_status & SKIP_MASK_STATUS_BATTERY_STATE) == SKIP_MASK_STATUS_BATTERY_STATE_LOW_WHILE_SAMPLING) => marginal batteries.
%//((system_status & SKIP_MASK_STATUS_BATTERY_STATE) == SKIP_MASK_STATUS_BATTERY_STATE_LOW_ALWAYS) => bad batteries.
%//((system_status & SKIP_MASK_STATUS_BATTERY_STATE) == SKIP_MASK_STATUS_BATTERY_STATE_MISSING) => no batteries.present.
SKIP_MASK_STATUS_BATTERY_STATE = hex2dec('0C');
SKIP_MASK_STATUS_BATTERY_STATE_GOOD = hex2dec('0');
SKIP_MASK_STATUS_BATTERY_STATE_LOW_WHILE_SAMPLING = hex2dec('4');
SKIP_MASK_STATUS_BATTERY_STATE_LOW_ALWAYS = hex2dec('8');
SKIP_MASK_STATUS_BATTERY_STATE_MISSING = hex2dec('0C');
end
end
