Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVATE5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVATE5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVATE53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:57:29 -0500
Received: from lakermmtao04.cox.net ([68.230.240.35]:44009 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261755AbVATE5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:57:16 -0500
In-Reply-To: <ufais5s4sdk.fsf@epithumia.math.uh.edu>
References: <Pine.LNX.4.30.0501191309500.20626-100000@swamp.bayern.net> <ufad5w07s93.fsf@epithumia.math.uh.edu> <18FE8C24-6A9D-11D9-A93E-000393ACC76E@mac.com> <ufais5s4sdk.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C0DA7983-6A9F-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
Date: Wed, 19 Jan 2005 23:57:15 -0500
To: Jason L Tibbitts III <tibbs@math.uh.edu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2005, at 23:49, Jason L Tibbitts III wrote:
> I'm not sure why you indicate that no in-engineering toolset exists
> for the 7000 cards.  It works fine on my 7810 and 7500-8 cards, as
> well as a bunch of 8506-4LP cards and of course the 9500S-4LP cards I
> have.  I don't think it would work on my 6800 cards, but those are
> just running JBOD with software RAID so there wouldn't be much point.

It could be that I just completely missed it, but I went to the 3ware
site and chose "7000".  There was not a "CLI" item, so I assumed there
wasn't a specific CLI just for the 7000s.  I later, however, found
that the 9000 CLIs (Normal and In-Eng) worked fine, so I never looked
for any others, such as 8000 or 8500 CLIs.  I may have made a mistake,
but I couldn't find a CLI in the "In Engineering"->"7000" section, and
I had a working solution, so I didn't try elsewhere.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


