Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280779AbRKBSl4>; Fri, 2 Nov 2001 13:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280778AbRKBSlr>; Fri, 2 Nov 2001 13:41:47 -0500
Received: from bugsbunny.sciences.univ-nantes.fr ([193.52.100.122]:60554 "HELO
	ensinfo.univ-nantes.fr") by vger.kernel.org with SMTP
	id <S280777AbRKBSlc>; Fri, 2 Nov 2001 13:41:32 -0500
Message-ID: <3BE30500.30703@ensinfo.univ-nantes.fr>
Date: Fri, 02 Nov 2001 21:41:36 +0100
From: MASSON FRANCOIS ALAIN <massonf@ensinfo.univ-nantes.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: X crash with kernel 2.4.12/.13(-ac5)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

--Here is some info about my computer:

Manufacturer: Packard-Bell
Processor: Intel Pentium MMX @ 233MHz
Video Card: Onboard S3 trio 64 v2
XFree: Mandrake XFree68 3.3.6 S3
Distrib: Mandrake 8.0
Kernel: Linus 2.4.12; Linus 2.4.13; Alan 2.4.13-ac5

--Here is the problem:

All run well till I start X.
But then the screen become black, no consol switching.
The SysKey respond.
A telnet or X from another networked computer work.
The system is still running, but the video card seem to be in a unstable
state.

-- Latest known working kernel:
Linus 2.4.9; Alan 2.4.9-ac4

-- About my kernel config:
Sorry but I don't have it on hand, but here is what I remember:

Processeur: Intel Pentium MMX
Video config: no frame buffer, no vga mode selction, no AGP, no DRI.

Please help,
francois

PS: As it's my first bug report, it may be not very exausted, don't tell me
what I done wrong and request futher informotion you need.


