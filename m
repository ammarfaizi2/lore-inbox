Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRGTOlS>; Fri, 20 Jul 2001 10:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbRGTOlI>; Fri, 20 Jul 2001 10:41:08 -0400
Received: from stanis.onastick.net ([207.96.1.49]:32017 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S266977AbRGTOkw>; Fri, 20 Jul 2001 10:40:52 -0400
Date: Fri, 20 Jul 2001 10:40:57 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-ac5 and VIA Athlon chipsets
Message-ID: <20010720104057.B23817@sigkill.net>
In-Reply-To: <3B55D2F2.71BF34D5@pp.htv.fi> <E15NMPS-0000Sg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15NMPS-0000Sg-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Will this fix (or get closer to fixing) the K7-optimization crashes? (I'm
still hoping its something that isn't getting initialized correctly,
rather than just a bug.  BurnK7/BurnMMX work fine, memtest86 and the MMX
memtest work, windows seems to be using the full memory bandwidth, etc.)

On Thu, 19 Jul 2001, Alan Cox did have cause to say:

> Excellent. I hope soon to push the official via fix to Linus. The other good
> news is that I now have some official VIA contacts, so where there is a real 
> need information should flow to the right places.

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
