/*
 * Copyright (C) 2007 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/** Make sound routing RPC calls to the ARM 9 on Dream (debug only) */

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <sys/uio.h>
#include <unistd.h>

#include <inc/snd.h>

#define __GLUE(a,b) a ## b
#define GLUE(a,b) __GLUE(a,b)
#define FUNC_RPC_SND_SET_DEVICE GLUE(rpc_snd_set_device_, SNDVERS)
#define FUNC_RPC_SND_SET_VOLUME GLUE(rpc_snd_set_volume_, SNDVERS)

CLIENT* client;
enum clnt_stat result;

void snd_set_device(int device) {
    printf("snd_set_device %d\n", device);

    rpc_snd_set_device_args args;
    args.device = device;
    args.ear_mute = RPC_SND_MUTE_UNMUTED;
    args.mic_mute = RPC_SND_MUTE_UNMUTED;
    args.callback_ptr = -1;
    args.client_data = 0;

    result = FUNC_RPC_SND_SET_DEVICE(&args, NULL, client);
}

void snd_set_volume(int device, int volume, int type) {
    printf("snd_set_volume %d\n", volume);

    rpc_snd_set_volume_args args;
    args.device = device;
    args.method = type;
    args.volume = volume;
    args.callback_ptr = -1;
    args.client_data = 0;

    result = FUNC_RPC_SND_SET_VOLUME(&args, NULL, client);
}

int main(int argc, char **argv) {

    client = clnt_create(NULL, SNDPROG, SNDVERS, NULL);
    if (client == NULL) {
        printf("Could not create RPC client\n");
        return -1;
    }

    if (argc == 1) {
        goto usage;
    }

    if (argc >= 3 && strcmp(argv[1], "snd_set_device") == 0) {
        int device = atoi(argv[2]);
        snd_set_device(device);
    } else if (argc >= 5 && strcmp(argv[1], "snd_set_volume") == 0) {
        int device = atoi(argv[2]);
        int volume = atoi(argv[3]);
        int type = atoi(argv[4]);
        snd_set_volume(device,volume, type);
    } else {
usage:
        printf("Usage:\n");
        printf("\tsndrpc snd_set_device [device]\n");
        printf("\tsndrpc snd_set_volume [device] [volume] [type]\n");
        printf("\n");
        printf("[device]\n");
        printf("RPC_HTC_SND_DEVICE_HANDSET  = 0,\n"
"RPC_HTC_SND_DEVICE_SPEAKER  = 1,\n"
"RPC_HTC_SND_DEVICE_HEADSET  = 2,\n"
"RPC_HTC_SND_DEVICE_BT       = 3,\n"
"RPC_HTC_SND_DEVICE_CARKIT   = 4,\n"
"RPC_HTC_SND_DEVICE_TTY_FULL = 5,\n"
"RPC_HTC_SND_DEVICE_TTY_VCO  = 6,\n"
"RPC_HTC_SND_DEVICE_TTY_HCO  = 7,\n"
"RPC_HTC_SND_DEVICE_TTY_EXT  = 8,\n"
"RPC_HTC_SND_DEVICE_TBD2     = 9,\n"
"RPC_HTC_SND_DEVICE_TBD3     =10,\n"
"RPC_HTC_SND_DEVICE_TBD4     =11,\n");
        printf("[type]\n");
        printf("RPC_SND_METHOD_VOICE = 0,\n"
"RPC_SND_METHOD_KEY_BEEP,\n"
"RPC_SND_METHOD_MESSAGE,\n"
"RPC_SND_METHOD_RING,\n"
"RPC_SND_METHOD_MIDI,\n"
"RPC_SND_METHOD_AUX,\n");
        return 0;
    }

    if (result == RPC_SUCCESS) {
        printf("SUCCESS\n");
    } else {
        printf("FAILED\n");
    }

    return 0;
}
