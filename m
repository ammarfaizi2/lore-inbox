Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269947AbRHELy1>; Sun, 5 Aug 2001 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHELyR>; Sun, 5 Aug 2001 07:54:17 -0400
Received: from web4902.mail.yahoo.com ([216.115.106.27]:36612 "HELO
	web4902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269937AbRHELyJ>; Sun, 5 Aug 2001 07:54:09 -0400
Message-ID: <20010805115418.28773.qmail@web4902.mail.yahoo.com>
Date: Sun, 5 Aug 2001 04:54:18 -0700 (PDT)
From: Vieri Di Paola <vieridipaola@yahoo.com>
Subject: 128M
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought a DIMM 128M RAM module and inserted it
in the motherboard. I took the old 2x8M SIMM modules.
However, my BIOS sees only 32M. I read though that I
can pass the kernel the argument "mem=128m" and Linux
should use all the available RAM. But this operation
leads to an error: "protection fault" and the boot
halts. Could there be a hardware problem with the DIMM
card? Or is just a BIOS thing, in which case there's
isn't anything I can do, or is there? I tried SuSE 6.3
and BestLinux Release 3 with both lilo and grub. I
passed kernel ... vmlinuz mem=128m but boot fails.
However any mem value below 32m works and the command
"top" shows the correct amount of memory.

Any suggestions?

Thanks in advance,

Vieri


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
