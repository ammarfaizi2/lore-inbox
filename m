Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282998AbRLWADC>; Sat, 22 Dec 2001 19:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283001AbRLWACx>; Sat, 22 Dec 2001 19:02:53 -0500
Received: from sense-jaxley-158.oz.net ([216.39.151.158]:11392 "EHLO
	manteador.and.stuff") by vger.kernel.org with ESMTP
	id <S282998AbRLWACp>; Sat, 22 Dec 2001 19:02:45 -0500
Message-ID: <1009065758.3c251f1edb6c4@manteador.and.stuff>
Date: Sat, 22 Dec 2001 16:02:38 -0800
From: c o r e <core@axley.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Strange 2.4 bug:  mysterious hang (UPDATED)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just tried the latest and greatest 2.4.17 stock kernel and the same
problem occurs and is just as reproducible.  The system locks _hard_ and
requires hitting the reset button or a power cycle (ctrl+alt+del has no affect).
 I updated the information that has changed below.

I am not subscribed so if you could cc me on a reply, that would be great.

[4.] Kernel version:  

Linux version 2.4.17jaxley1 (root@mysystem) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-98)) #2 SMP Sat Dec 22 15:22:55 PST 2001

[7.3.] Module information:

emu10k1                57360   0 (autoclean)
sound                  56704   0 (autoclean) [emu10k1]
ac97_codec              9632   0 (autoclean) [emu10k1]
soundcore               3984   7 (autoclean) [emu10k1 sound]
3c59x                  25888   1
ide-cd                 26592   0
cdrom                  27840   0 [ide-cd]
usb-uhci               22176   0 (unused)
usbcore                51840   1 [usb-uhci]

Thanks,

-core

