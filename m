Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbRGMHFS>; Fri, 13 Jul 2001 03:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266937AbRGMHFJ>; Fri, 13 Jul 2001 03:05:09 -0400
Received: from mohawk.n-online.net ([195.30.220.100]:13331 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S266936AbRGMHFA>; Fri, 13 Jul 2001 03:05:00 -0400
Date: Fri, 13 Jul 2001 09:00:54 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010713070503Z266936-720+1911@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Seems to be the problem with the AMD optimazion in the kernel.

> This sounds like a hardware problem -- none of the Athlons I'm using
> experience such problems, but then I'm using boards with AMD, ALi and SiS
> chipsets, but no VIA.  Try updating your BIOS and making your memory
> settings more conservative.  If that doesn't help, I suggest replacing
> your motherboard.

It's my second Athlon!
(AMD 650, ASUS K7M, 256 MB PC133  => AMD 1300, EPOX 8KTA3ue+, 256MB PC133)

It still doesn't run solid with any of the two machines! (400 Watt Powersupply!)

My BIOS is the latest release.
I've just phoned with Epox here in Germany and they told me, that their boards
are testet with linux and they are working.

I've already tried to slow down the bus, cpu and memory
(254 MHz FSB, 123 SDRAM, 1234 MHz) but this didn't help me out.

NOTE : Things are ONLY crashing when being NOT root!!
       If i log in as root i can't get KDE/Gnome apps to crash, only when i'm a
       "normal" user! Opening xterm as normal user, su-ing to root and starting 
       applications works too!

I'm very, very, very confused!

Please help me :-)

Thomas

