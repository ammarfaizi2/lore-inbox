Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRLZLt0>; Wed, 26 Dec 2001 06:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286197AbRLZLtG>; Wed, 26 Dec 2001 06:49:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:65502 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S286196AbRLZLtD>; Wed, 26 Dec 2001 06:49:03 -0500
Date: Wed, 26 Dec 2001 12:49:01 +0100
From: bert hubert <ahu@ds9a.nl>
To: Thomas Winischhofer <tw@webit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: @Linus, Marcello, (Alan?) (regards sisfb)
Message-ID: <20011226124901.A14221@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Thomas Winischhofer <tw@webit.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C2349C8.1DF70E5F@falke.mail> <3C28B113.7F4CFA0E@webit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C28B113.7F4CFA0E@webit.com>; from tw@webit.com on Tue, Dec 25, 2001 at 06:02:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2001 at 06:02:11PM +0100, Thomas Winischhofer wrote:
> 
> Hi again.
> 
> I just finished an update for the new sisfb driver which is available
> here:
> 
> http://members.aon.at/~twinisch/sisfb_src_251201.tar.gz

Works for me! Thanks! 

On a Gericom Webgine Laptop:
Linux version 2.5.0 (ahu@snapcount) (gcc version 2.95.4 20011006 (Debian prerelease)) #2 Wed Dec 26 12:31:08 CET 2001
Kernel command line: auto BOOT_IMAGE=sis ro root=301 video=sisfb:mode:1024x768x16
(...)
SiS ROM signature = 55 ffffffaa 60 ffffffe9 5f  2 32 2e 30 32 2e 31 (U*_B2.02.1)
sisfb: Assuming BIOS at 0xc00c0000 and copied to RAM (Sig: 55 aa 60)
sisfb: framebuffer at 0xd0000000, mapped to 0xd001c000, size 8192k
sisfb: MMIO at 0xdfee0000, mapped to 0xd081d000, size 128k
sisfb: LVDS bridge and CHRONTEL TV converter detected
sisfb: mode is 1024x768x16 (60Hz), linelength=2048
Console: switching to colour frame buffer device 128x48
fb0: SIS 630 frame buffer device, Version 1.3.09

> The update was necessary for making sisfb co-operate better with the new
> X driver.

Will test that next.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
