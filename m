Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUHYNmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUHYNmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 09:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHYNmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 09:42:13 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:57551 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267397AbUHYNl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 09:41:57 -0400
Message-ID: <412C9724.7060304@blueyonder.co.uk>
Date: Wed, 25 Aug 2004 14:41:56 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc1
Content-Type: multipart/mixed;
 boundary="------------060201030509050206030703"
X-OriginalArrivalTime: 25 Aug 2004 13:42:19.0586 (UTC) FILETIME=[57881A20:01C48AA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201030509050206030703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On x86_64, SuSE 9.1, KDE 3.3.0. The KDE splash screen comes up and gets 
stuck on "Initializing Services" and no further, same in Gnome 2.4. 
Booting up 2.6.8.1-mm4, it's fine. Messages from /var/log/warn.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====


--------------060201030509050206030703
Content-Type: text/plain;
 name="269rc1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="269rc1"

Aug 25 14:02:43 Boycie kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Aug 25 14:02:43 Boycie kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Aug 25 14:02:43 Boycie kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Aug 25 14:02:43 Boycie last message repeated 2 times
Aug 25 14:03:08 Boycie xinetd[8883]: Exiting...
Aug 25 14:03:12 Boycie kernel: warning: many lost ticks.
Aug 25 14:03:12 Boycie kernel: Your time source seems to be instable or some driver is hogging interupts
Aug 25 14:03:12 Boycie kernel: rip acpi_ec_write+0xdc/0x122
Aug 25 14:06:59 Boycie kernel: PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
Aug 25 14:06:59 Boycie kernel: ttyS0 at I/O 0x3f8 (irq = 17) is a 16550A
Aug 25 14:07:06 Boycie kernel: powernow-k8: ph2 null fid transition 0xa
Aug 25 14:07:08 Boycie ifup: No configuration found for sit0
Aug 25 14:07:13 Boycie ntpdate[7392]: sendto(128.118.25.3): Operation not permitted
Aug 25 14:07:16 Boycie last message repeated 3 times
Aug 25 14:07:17 Boycie ntpdate[7392]: no server suitable for synchronization found
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'AdminSession' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:27
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'GreeterPosFixed' in section [X-*-Greeter] at /etc/opt/kde3/share
/config/kdm/kdmrc:39
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'GreeterPosX' in section [X-*-Greeter] at /etc/opt/kde3/share/con
fig/kdm/kdmrc:40
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'GreeterPosY' in section [X-*-Greeter] at /etc/opt/kde3/share/con
fig/kdm/kdmrc:41
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'SessionTypes' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:50
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'AdminSession' in section [X-:*-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:64
Aug 25 14:07:21 Boycie kdm_config[7643]: Unrecognized key 'AdminSession' in section [X-:0-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:73
Aug 25 14:07:24 Boycie amavis(client)[7747]: failed to connect(): No such file or directory
Aug 25 14:07:31 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:07:40 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:12:49 Boycie kdm[7618]: X server for display :0 terminated unexpectedly
Aug 25 14:12:53 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:14:12 Boycie kdm[7618]: X server for display :0 terminated unexpectedly
Aug 25 14:14:16 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'AdminSession' in section [X-*-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:27
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'GreeterPosFixed' in section [X-*-Greeter] at /etc/opt/kde3/shar
e/config/kdm/kdmrc:39
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'GreeterPosX' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:40
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'GreeterPosY' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:41
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'SessionTypes' in section [X-*-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:50
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'AdminSession' in section [X-:*-Greeter] at /etc/opt/kde3/share/
config/kdm/kdmrc:64
Aug 25 14:15:13 Boycie kdm_config[13161]: Unrecognized key 'AdminSession' in section [X-:0-Greeter] at /etc/opt/kde3/share/
config/kdm/kdmrc:73
Aug 25 14:15:16 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:15:19 Boycie kdm[13160]: X server died during startup
Aug 25 14:15:19 Boycie kdm[13160]: X server for display :0 can't be started, session disabled
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'AdminSession' in section [X-*-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:27
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'GreeterPosFixed' in section [X-*-Greeter] at /etc/opt/kde3/shar
e/config/kdm/kdmrc:39
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'GreeterPosX' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:40
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'GreeterPosY' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:41
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'SessionTypes' in section [X-*-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:50
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'AdminSession' in section [X-:*-Greeter] at /etc/opt/kde3/share/
config/kdm/kdmrc:64
Aug 25 14:17:08 Boycie kdm_config[17616]: Unrecognized key 'AdminSession' in section [X-:0-Greeter] at /etc/opt/kde3/share/
config/kdm/kdmrc:73
Aug 25 14:17:10 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:17:14 Boycie kdm[17615]: X server died during startup
Aug 25 14:17:14 Boycie kdm[17615]: X server for display :0 can't be started, session disabled
Aug 25 14:20:17 Boycie xinetd[7895]: Exiting...
Aug 25 14:22:51 Boycie kernel: PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
Aug 25 14:22:55 Boycie kernel: powernow-k8: ph2 null fid transition 0xa
Aug 25 14:22:58 Boycie ifup: No configuration found for sit0
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'AdminSession' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:27
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'GreeterPosFixed' in section [X-*-Greeter] at /etc/opt/kde3/share
/config/kdm/kdmrc:39
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'GreeterPosX' in section [X-*-Greeter] at /etc/opt/kde3/share/con
fig/kdm/kdmrc:40
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'GreeterPosY' in section [X-*-Greeter] at /etc/opt/kde3/share/con
fig/kdm/kdmrc:41
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'SessionTypes' in section [X-*-Greeter] at /etc/opt/kde3/share/co
nfig/kdm/kdmrc:50
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'AdminSession' in section [X-:*-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:64
Aug 25 14:23:07 Boycie kdm_config[8627]: Unrecognized key 'AdminSession' in section [X-:0-Greeter] at /etc/opt/kde3/share/c
onfig/kdm/kdmrc:73
Aug 25 14:23:12 Boycie amavis(client)[8779]: failed to connect(): No such file or directory
Aug 25 14:23:12 Boycie amavis(client)[8779]: failing with EX_TEMPFAIL: No such file or directory
Aug 25 14:23:14 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:23:24 Boycie kernel: mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x200000
Aug 25 14:23:46 Boycie kernel: warning: many lost ticks.
Aug 25 14:23:46 Boycie kernel: Your time source seems to be instable or some driver is hogging interupts
Aug 25 14:23:46 Boycie kernel: rip acpi_ec_write+0xdc/0x122
Aug 25 14:24:21 Boycie kernel: warning: many lost ticks.
Aug 25 14:24:21 Boycie kernel: Your time source seems to be instable or some driver is hogging interupts


--------------060201030509050206030703--
