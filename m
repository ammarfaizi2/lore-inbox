Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284268AbRLBSzJ>; Sun, 2 Dec 2001 13:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282561AbRLBSzC>; Sun, 2 Dec 2001 13:55:02 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:45065 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S282480AbRLBSyy>; Sun, 2 Dec 2001 13:54:54 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux/Pro [was Re: Coding style - a non-issue]
Date: Sun, 2 Dec 2001 10:54:41 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBKEMAECAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16A71v-0006h9-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
> Sent: Saturday, December 01, 2001 2:06 AM
> To: Andrew Morton
> Cc: Davide Libenzi; Larry McVoy; Daniel Phillips; Henning
> Schmiedehausen; Jeff Garzik; linux-kernel@vger.kernel.org
> Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]

> Another thing for 2.5 is going to be to weed out the unused and
> unmaintained
> drivers, and either someone fixes them or they go down the comsic
> toilet and
> we pull the flush handle before 2.6 comes out.
>
> Thankfully the scsi layer breakage is going to help no end in the area of
> clockwork 8 bit scsi controllers, which is major culprit number
> 1. number 2
> is probably the audio which is hopefully going to go away with ALSA based
> code.

I am *completely* underwhelmed by ALSA, *especially* in the areas of
usability and documentation! I have an M-Audio Delta 66 sound card and I was
unable to get ALSA to work with it. At the time I attempted this, I did not
have the free time to do c-code-level integration work; I needed something
that was plug-and-play with usable documentation. I ended up buying the
closed-source OSS/Linux driver, which at least installs and boots. Their
documentation isn't much better, and I finally was forced to dual-boot
Windows 2000 to get a usable audio tool set for this device.

My point here is that just because a composer is *capable* of doing
integration work and building or repairing tools (and I am) does *not* mean
he (or she :-) has either the time or the willingness to do so (and I
don't).
--
Take Your Trading to the Next Level!
M. Edward Borasky, Meta-Trading Coach

znmeb@borasky-research.net
http://www.meta-trading-coach.com
http://groups.yahoo.com/group/meta-trading-coach

