Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUJLI2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUJLI2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUJLI2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:28:03 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:3339 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S269530AbUJLI0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:26:03 -0400
Message-ID: <416B9517.7010708@blueyonder.co.uk>
Date: Tue, 12 Oct 2004 09:25:59 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc4-mm1 Oops [2]
Content-Type: multipart/mixed;
 boundary="------------040202010303050505010503"
X-OriginalArrivalTime: 12 Oct 2004 08:26:24.0362 (UTC) FILETIME=[292A74A0:01C4B035]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202010303050505010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This one on attempting to start firefox.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

--------------040202010303050505010503
Content-Type: text/plain;
 name="PRE2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PRE2"

obe_interface
usbhid 1-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [KYE EasyTrack Optical U+P] on usb-0000:00:10.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Linux video capture interface: v1.00
ov511 3-1:1.0: usb_probe_interface
ov511 3-1:1.0: usb_probe_interface - got id
drivers/usb/media/ov511.c: USB OV511+ video device found
drivers/usb/media/ov511.c: model: Creative Labs WebCam 3
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/media/ov511.c: Sensor is an OV7620AE
drivers/usb/media/ov511.c: Enabling 511+/7620AE workaround
drivers/usb/media/ov511.c: Device at usb-0000:00:10.2-1 registered to minor 0
usbcore: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
usbserial_generic 3-2:1.0: usb_probe_interface
usbserial_generic 3-2:1.0: usb_probe_interface - got id
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 3-2:1.0: usb_probe_interface
pl2303 3-2:1.0: usb_probe_interface - got id
pl2303 3-2:1.0: PL-2303 converter detected
usb 3-2: PL-2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.12
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
Bluetooth: HCI UART driver ver 2.1
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: VHCI driver ver 1.1
Bluetooth: L2CAP ver 2.4
Bluetooth: L2CAP socket layer initialized
i2c-core: driver eeprom registered.
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0050
i2c_adapter i2c-0: client [eeprom] registered to adapter
registering 0-0050
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0051
i2c_adapter i2c-0: client [eeprom] registered to adapter
registering 0-0051
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0052
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0053
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0054
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0055
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0056
i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0057
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRS] (54 C)
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip handle_IRQ_event+0x20/0x60
ACPI: Thermal Zone [THRC] (70 C)
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:11.5 to 64
Unable to handle kernel paging request at 00000000000c2b04 RIP: 
<ffffffff8013609c>{profile_hit+44}
PML4 1b3dc067 PGD 1a5bb067 PMD 0 
Oops: 0002 [1] PREEMPT 
CPU 0 
Modules linked in: snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore thermal processor fan button ac eeprom i2c_sensor l2cap hci_vhci hci_uart hci_usb bluetooth pl2303 usbserial ov511 videodev usbhid ehci_hcd i2c_viapro i2c_core tg3 uhci_hcd ohci1394 ieee1394 serial_cs ds yenta_socket pcmcia_core usbcore evdev sg scsi_mod vfat fat ide_cd
Pid: 6816, comm: mysqld-max Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013609c>] <ffffffff8013609c>{profile_hit+44}
RSP: 0018:000001001cfa5f20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 000001001a5b87c0 RCX: 0000000000000000
RDX: 000001001a5b8920 RSI: 00000000000c2b04 RDI: 0000000000000002
RBP: 000001001cfa5f68 R08: 0000000000000001 R09: 0000000000ac05d0
R10: ffffffffffffffff R11: 0000000000000202 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000007fbffff910 R15: ffffffff804c5420
FS:  0000002a964d34c0(0000) GS:ffffffff80509040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000c2b04 CR3: 0000000000101000 CR4: 00000000000006e0
Process mysqld-max (pid: 6816, threadinfo 000001001cfa4000, task 000001001a5b87c0)
Stack: ffffffff801317f6 0000000000000000 0000000000000006 00000009bffff964 
       0000002a964d34c0 0000000000000000 0000007fbffff964 0000007fbffff910 
       0000000000000000 000001001cfa5f78 
Call Trace:<ffffffff801317f6>{setscheduler+214} <ffffffff801319d9>{sys_sched_setscheduler+9} 
       <ffffffff8011060e>{system_call+126} 

Code: ff 06 c3 90 48 83 ec 08 48 89 fa be 80 01 00 00 48 c7 c7 1a 
RIP <ffffffff8013609c>{profile_hit+44} RSP <000001001cfa5f20>
CR2: 00000000000c2b04
 <6>note: mysqld-max[6816] exited with preempt_count 2
scheduling while atomic: mysqld-max/0x04000002/6816

Call Trace:<ffffffff8038e3c0>{schedule+128} <ffffffff8013504c>{__call_console_drivers+76} 
       <ffffffff8038eacf>{cond_resched+63} <ffffffff80169ed9>{unmap_vmas+1529} 
       <ffffffff8016cce6>{exit_mmap+118} <ffffffff80133200>{mmput+48} 
       <ffffffff80138c19>{do_exit+505} <ffffffff8011195e>{oops_end+62} 
       <ffffffff801217df>{do_page_fault+1263} <ffffffff801691f4>{do_no_page+1332} 
       <ffffffff8016a956>{handle_mm_fault+326} <ffffffff8015b78b>{generic_file_read+187} 
       <ffffffff80110f29>{error_exit+0} <ffffffff8013609c>{profile_hit+44} 
       <ffffffff801317f6>{setscheduler+214} <ffffffff801319d9>{sys_sched_setscheduler+9} 
       <ffffffff8011060e>{system_call+126} 
scheduling while atomic: mysqld-max/0x04000002/6816

Call Trace:<ffffffff8038e3c0>{schedule+128} <ffffffff8038eacf>{cond_resched+63} 
       <ffffffff80169ed9>{unmap_vmas+1529} <ffffffff8016cce6>{exit_mmap+118} 
       <ffffffff80133200>{mmput+48} <ffffffff80138c19>{do_exit+505} 
       <ffffffff8011195e>{oops_end+62} <ffffffff801217df>{do_page_fault+1263} 
       <ffffffff801691f4>{do_no_page+1332} <ffffffff8016a956>{handle_mm_fault+326} 
       <ffffffff8015b78b>{generic_file_read+187} <ffffffff80110f29>{error_exit+0} 
       <ffffffff8013609c>{profile_hit+44} <ffffffff801317f6>{setscheduler+214} 
       <ffffffff801319d9>{sys_sched_setscheduler+9} <ffffffff8011060e>{system_call+126} 
       
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff804773e0(lo)
IPv6 over IPv4 tunneling driver
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
powernow-k8: cpu_init done, current fid 0xa, vid 0x0
powernow-k8: ph2 null fid transition 0xa
eth0: no IPv6 routers present
uhci_hcd 0000:00:10.2: shutdown urb 000001001f833748 pipe 00008480 ep1in-iso
uhci_hcd 0000:00:10.2: shutdown urb 000001001c3fcaf8 pipe 00008480 ep1in-iso
uhci_hcd 0000:00:10.2: shutdown urb 000001001f833530 pipe 00008480 ep1in-iso
uhci_hcd 0000:00:10.2: shutdown urb 0000010017b1ecd0 pipe 00008480 ep1in-iso
Unable to handle kernel paging request at 00000000000c2b04 RIP: 
<ffffffff8013609c>{profile_hit+44}
PML4 117a9067 PGD 116e9067 PMD 0 
Oops: 0002 [2] PREEMPT 
CPU 0 
Modules linked in: autofs cpufreq_userspace powernow_k8 freq_table snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss ipv6 snd_ioctl32 snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore thermal processor fan button ac eeprom i2c_sensor l2cap hci_vhci hci_uart hci_usb bluetooth pl2303 usbserial ov511 videodev usbhid ehci_hcd i2c_viapro i2c_core tg3 uhci_hcd ohci1394 ieee1394 serial_cs ds yenta_socket pcmcia_core usbcore evdev sg scsi_mod vfat fat ide_cd
Pid: 14242, comm: artswrapper Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013609c>] <ffffffff8013609c>{profile_hit+44}
RSP: 0018:0000010011791f20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000010018f39840 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 00000000000c2b04 RDI: 0000000000000002
RBP: 0000010011791f68 R08: 0000000000000001 R09: 0000002a955612d0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
R13: 00000000ffffffea R14: 0000000000000000 R15: ffffffff804c5420
FS:  0000002a95ba9840(0000) GS:ffffffff80509040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000c2b04 CR3: 0000000000101000 CR4: 00000000000006e0
Process artswrapper (pid: 14242, threadinfo 0000010011790000, task 0000010018f39840)
Stack: ffffffff801317f6 0000007fbfffee78 0000000000000002 0000003211791f78 
       0000000000000032 000000000000000c 0000000000000000 0000000000000000 
       0000000000000000 0000010011791f78 
Call Trace:<ffffffff801317f6>{setscheduler+214} <ffffffff801319d9>{sys_sched_setscheduler+9} 
       <ffffffff8011060e>{system_call+126} 

Code: ff 06 c3 90 48 83 ec 08 48 89 fa be 80 01 00 00 48 c7 c7 1a 
RIP <ffffffff8013609c>{profile_hit+44} RSP <0000010011791f20>
CR2: 00000000000c2b04
 <6>note: artswrapper[14242] exited with preempt_count 2
scheduling while atomic: artswrapper/0x04000002/14242

Call Trace:<ffffffff8038e3c0>{schedule+128} <ffffffff8013504c>{__call_console_drivers+76} 
       <ffffffff8038eacf>{cond_resched+63} <ffffffff80169ed9>{unmap_vmas+1529} 
       <ffffffff8016cce6>{exit_mmap+118} <ffffffff80133200>{mmput+48} 
       <ffffffff80138c19>{do_exit+505} <ffffffff8011195e>{oops_end+62} 
       <ffffffff801217df>{do_page_fault+1263} <ffffffff801691f4>{do_no_page+1332} 
       <ffffffff8016a956>{handle_mm_fault+326} <ffffffff80110f29>{error_exit+0} 
       <ffffffff8013609c>{profile_hit+44} <ffffffff801317f6>{setscheduler+214} 
       <ffffffff801319d9>{sys_sched_setscheduler+9} <ffffffff8011060e>{system_call+126} 
       
Unable to handle kernel paging request at 00000000000c2b04 RIP: 
<ffffffff8013609c>{profile_hit+44}
PML4 96d7067 PGD 968d067 PMD 0 
Oops: 0002 [3] PREEMPT 
CPU 0 
Modules linked in: autofs cpufreq_userspace powernow_k8 freq_table snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss ipv6 snd_ioctl32 snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore thermal processor fan button ac eeprom i2c_sensor l2cap hci_vhci hci_uart hci_usb bluetooth pl2303 usbserial ov511 videodev usbhid ehci_hcd i2c_viapro i2c_core tg3 uhci_hcd ohci1394 ieee1394 serial_cs ds yenta_socket pcmcia_core usbcore evdev sg scsi_mod vfat fat ide_cd
Pid: 14558, comm: firefox-bin Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013609c>] <ffffffff8013609c>{profile_hit+44}
RSP: 0018:00000100097a7f20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000010017b21030 RCX: 0000000000000000
RDX: 0000010017b21190 RSI: 00000000000c2b04 RDI: 0000000000000002
RBP: 00000100097a7f68 R08: 0000000000000001 R09: 00000000ffffcc78
R10: 00000100097a6000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000000000000000 R15: ffffffff804c5420
FS:  0000002a98b083c0(0000) GS:ffffffff80509040(005b) knlGS:0000000056076200
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000000c2b04 CR3: 0000000000101000 CR4: 00000000000006e0
Process firefox-bin (pid: 14558, threadinfo 00000100097a6000, task 0000010017b21030)
Stack: ffffffff801317f6 00000100097a7f78 0000000000000006 00000000097a7f78 
       00000000000038de 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 00000100097a7f78 
Call Trace:<ffffffff801317f6>{setscheduler+214} <ffffffff801319d9>{sys_sched_setscheduler+9} 
       <ffffffff801227d3>{cstar_do_call+27} 

Code: ff 06 c3 90 48 83 ec 08 48 89 fa be 80 01 00 00 48 c7 c7 1a 
RIP <ffffffff8013609c>{profile_hit+44} RSP <00000100097a7f20>
CR2: 00000000000c2b04
 <6>note: firefox-bin[14558] exited with preempt_count 2
scheduling while atomic: firefox-bin/0x04000002/14558

Call Trace:<ffffffff8038e3c0>{schedule+128} <ffffffff8038eb78>{preempt_schedule+88} 
       <ffffffff8038eacf>{cond_resched+63} <ffffffff80169ed9>{unmap_vmas+1529} 
       <ffffffff8016cce6>{exit_mmap+118} <ffffffff80133200>{mmput+48} 
       <ffffffff80138c19>{do_exit+505} <ffffffff802a2347>{do_unblank_screen+119} 
       <ffffffff801217df>{do_page_fault+1263} <ffffffff801691f4>{do_no_page+1332} 
       <ffffffff8016a956>{handle_mm_fault+326} <ffffffff80110f29>{error_exit+0} 
       <ffffffff8013609c>{profile_hit+44} <ffffffff801317f6>{setscheduler+214} 
       <ffffffff801319d9>{sys_sched_setscheduler+9} <ffffffff801227d3>{cstar_do_call+27} 
       
Unable to handle kernel paging request at 00000000000c2b04 RIP: 
<ffffffff8013609c>{profile_hit+44}
PML4 7d77067 PGD 7d4d067 PMD 0 
Oops: 0002 [4] PREEMPT 
CPU 0 
Modules linked in: autofs cpufreq_userspace powernow_k8 freq_table snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss ipv6 snd_ioctl32 snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore thermal processor fan button ac eeprom i2c_sensor l2cap hci_vhci hci_uart hci_usb bluetooth pl2303 usbserial ov511 videodev usbhid ehci_hcd i2c_viapro i2c_core tg3 uhci_hcd ohci1394 ieee1394 serial_cs ds yenta_socket pcmcia_core usbcore evdev sg scsi_mod vfat fat ide_cd
Pid: 14596, comm: firefox-bin Not tainted 2.6.9-rc4-mm1
RIP: 0010:[<ffffffff8013609c>] <ffffffff8013609c>{profile_hit+44}
RSP: 0018:0000010007d59f20  EFLAGS: 00010082
RAX: 0000000000000000 RBX: 00000100161d3880 RCX: 0000000000000000
RDX: 00000100161d39e0 RSI: 00000000000c2b04 RDI: 0000000000000002
RBP: 0000010007d59f68 R08: 0000000000000001 R09: 00000000ffffcc78
R10: 0000010007d58000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000ffffffea R14: 0000000000000000 R15: ffffffff804c5420
FS:  0000002a95f0d980(0000) GS:ffffffff80509040(005b) knlGS:0000000056076200
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000000c2b04 CR3: 0000000000101000 CR4: 00000000000006e0
Process firefox-bin (pid: 14596, threadinfo 0000010007d58000, task 00000100161d3880)
Stack: ffffffff801317f6 0000010007d59f78 0000000000000002 0000000007d59f78 
       0000000000003904 0000000000000000 0000000000000000 0000000000000000 
       0000000000000000 0000010007d59f78 
Call Trace:<ffffffff801317f6>{setscheduler+214} <ffffffff801319d9>{sys_sched_setscheduler+9} 
       <ffffffff801227d3>{cstar_do_call+27} 

Code: ff 06 c3 90 48 83 ec 08 48 89 fa be 80 01 00 00 48 c7 c7 1a 
RIP <ffffffff8013609c>{profile_hit+44} RSP <0000010007d59f20>
CR2: 00000000000c2b04
 <6>note: firefox-bin[14596] exited with preempt_count 2
scheduling while atomic: firefox-bin/0x04000002/14596

Call Trace:<ffffffff8038e3c0>{schedule+128} <ffffffff8013504c>{__call_console_drivers+76} 
       <ffffffff8038eacf>{cond_resched+63} <ffffffff80169ed9>{unmap_vmas+1529} 
       <ffffffff8016cce6>{exit_mmap+118} <ffffffff80133200>{mmput+48} 
       <ffffffff80138c19>{do_exit+505} <ffffffff8011195e>{oops_end+62} 
       <ffffffff801217df>{do_page_fault+1263} <ffffffff801691f4>{do_no_page+1332} 
       <ffffffff8016a956>{handle_mm_fault+326} <ffffffff80110f29>{error_exit+0} 
       <ffffffff8013609c>{profile_hit+44} <ffffffff801317f6>{setscheduler+214} 
       <ffffffff801319d9>{sys_sched_setscheduler+9} <ffffffff801227d3>{cstar_do_call+27} 
       

--------------040202010303050505010503--
