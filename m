Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266830AbRGLVy2>; Thu, 12 Jul 2001 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGLVyH>; Thu, 12 Jul 2001 17:54:07 -0400
Received: from 213.237.80.78.adsl.kd.worldonline.dk ([213.237.80.78]:14642
	"HELO binary.dyndns.dk") by vger.kernel.org with SMTP
	id <S266795AbRGLVx7>; Thu, 12 Jul 2001 17:53:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kenneth Vestergaard Schmidt <charon@debian.org>
Organization: Debian
To: linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
Date: Thu, 12 Jul 2001 23:53:57 +0200
X-Mailer: KMail [version 1.2.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010712215357.91B6DB6357@binary.dyndns.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Foerster wrote:
> Seems to be the problem with the AMD optimazion in the kernel.

Funny, I have only had one minor problem with my setup. It's the same 
processor, only with one 512 meg PC133 block, and the ASUS A7V133 
motherboard (which is equipped with the same chipset). My videocard is also 
the same (ASUS V-7700), but my PSU is only 300Mhz.

The only instability I've experienced is when I was running KDM on both vt7 
and vt8, and then logging out from X. Sometimes (entirely random) it would 
freeze solid (something like once a week). I've had this setup since 2.4.1, 
and the kernel has always been compiled with Athlon optimizations, and with 
VIA 82CXXX chipset support.

As a sidenote, Linux runs blazingly fast! I was a little worried about the 
recent mucking about VIA-chipsets when I ordered my hardware, but those 
worries has been put to shame... Or maybe I'm just lucky ;-)

Oh, yeah, my computer is turned on and using cycles some 5-10 hours per 
day, right now running 2.4.6.

If there's anything I can help with regarding this VIA-problem, please let 
me know. I'm probably not worth anything as a kernel hacker, but I'm 
willing to test kernel-patches to see if they cause/cure instability.

Best Regards

Kenneth Vestergaard Schmidt
