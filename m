Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270451AbRHHLEO>; Wed, 8 Aug 2001 07:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270453AbRHHLEF>; Wed, 8 Aug 2001 07:04:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50183 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270451AbRHHLEA>; Wed, 8 Aug 2001 07:04:00 -0400
Subject: Re: is this a bug?
To: kernel@blackhole.compendium-tech.com (Dr. Kelsey Hudson)
Date: Wed, 8 Aug 2001 12:05:54 +0100 (BST)
Cc: thodoris@cs.teiher.gr (Thodoris Pitikaris), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108071916100.23797-100000@sol.compendium-tech.com> from "Dr. Kelsey Hudson" at Aug 07, 2001 07:19:16 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UR9v-000546-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > cputype=Athlon I continiusly experienced this crash.When I compiled with
> > cputype=i686 everything went smooth (OS is Redhat 7.1)
> 
> It's a bug in that screwed up compiler redhat shipped with 7.1. AFAIK, the
> only difference between an athlon-specific kernel and an i686-specific
> kernel are the options in the compiler command line when compiling the
> kernel.

Please stop deliberately spreading misinformation. The last thing an end
user with a problem needs is a bigot with an axe to grind lying to them to
make a political point.

Its the classic 'bought the wrong VIA chipset mainboard' problem

Alan
