Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRHFAUC>; Sun, 5 Aug 2001 20:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRHFATw>; Sun, 5 Aug 2001 20:19:52 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:13953 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S265277AbRHFATi>; Sun, 5 Aug 2001 20:19:38 -0400
Message-ID: <3B6DE195.C604879A@randomlogic.com>
Date: Sun, 05 Aug 2001 17:15:17 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kplug-list@kernel-panic.org,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon, AGP, and PCI
In-Reply-To: <200108050019.f750J6t24095@antimatter.net>
		<3B6D2304.E3D9D83E@randomlogic.com> <20010805095853.04315de4.dlooney1@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Looney wrote:
> 

[SNIP]
> In general your dual athlon system whupped mine good, especially in the Dhrystone/Whetstone categories (more than 2x), and it did ~50% better in almost every category except process creation (some overhead for dual cpu machines ?) So it would seem to scale reasonably.
> 
> OTOH, what about bang for buck ?  I built the basic machine (case/power supply/motherboard/cpu/mem/20 GB HD/8MB matrox AGP) for about $280, but added about another $170 of stuff (PCI sound, PCI linmodem, NIC, panasonic CD/CDR/CDRW). I am sure others out there could probably do much better though, as I just bought stuff from catalogs or retail, and didn't scrounge.
> 

~$2600 for this machine:

Dual Athlon 1.4GHz (non-MP) ($229 ech.)
Tyan K7 Thunder ($600)
 - Dual Channel Ultra 160 SCSI (AIC7899P)
 - ATA 100 IDE
 - Dual 3c980 TX 10/100 NICs
 - 4 port USB
 - 6 64/32-bit PCI 2.0 slots
 - 1 AGP Pro slot
 - Onboard I/O
 - Winbond hardware monitor
256MB ECC Reg. DDR SDRAM ($99)
IBM Ultra 160 36GB HDD ($609)
IBM ATA100 30GB HDD ($169)
Yamaha DVD-ROM ($30)
Sony 52x CDROM ($40)
Asus V8200 (GeForce 3) Deluxe (64MB DDR) ($415)
Sound Blaster Live! ($99)
Full Tower case w/NMB 450W power supply ($159)


I ran the test in multi-user mode (silly me, I was half asleep when I
ran it and not thinking :). I will run it in single in a bit and re-post
the results. I also need to find a 3D/graphics benchmark besides Quake
3. (Hey, anyone remember how to enable the FPS display in Quake 3?)

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
