Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRKMSAX>; Tue, 13 Nov 2001 13:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRKMSAN>; Tue, 13 Nov 2001 13:00:13 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:31620 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S277713AbRKMSAD>; Tue, 13 Nov 2001 13:00:03 -0500
Message-ID: <3BF15FA1.94DFE0F5@randomlogic.com>
Date: Tue, 13 Nov 2001 10:00:01 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <4BC5D32775F0D311963F0090276DD12E07817A@SYNX10>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giles Tyson wrote:
> 
> -----Original Message-----
> From: Jeffrey W. Baker [mailto:jwbaker@acm.org]
> >On Tue, 2001-11-13 at 05:19, Martin Eriksson wrote:
> >> I'm hearing rumours about my University wanting to set up a cluster with
> AMD
> >> Athlon XP+DDR computers, so I wonder what chipset is most stable under
> >> Linux?
> >>
> >> I assume it's the AMD DDR chipset, but I want to be pretty sure.
> 
> >I have no problems with the 1400MHz Athlon on AMD 760, including DRI
> >using the AGP bridge.
> 
> It's my understanding that among boards with the same chipset, some may work
> while others do not.  I have tested an Iwill KK266+Raid, with KT133A, and it
> would not run with athlon optimizations.  I also have tried an Epox 8KHA+,
> with KT266A, and it has been perfectly stable so far, for three days.

I have yet to try the latest kernels, but I have an Asus A7V133 (PC133,
not DDR) and a Tyan K7 Thunder (dual). Both are running 1.4GHz Athlons
and both have had problems. In both cases the IDE has been a problem. On
the Tyan, I've had to turn off DMA or it will lock up. I have not messed
with the Asus system yet to see exactly where the problem is.

I'm looking forward to seeing how a newer kernel works (I am running
2.4.9ac10 on my Tyan and a stock Red Hat 7.1 kernel on the Asus until I
upgrade it)

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
