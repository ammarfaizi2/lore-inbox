Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131939AbRACATi>; Tue, 2 Jan 2001 19:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131928AbRACAT3>; Tue, 2 Jan 2001 19:19:29 -0500
Received: from [194.73.73.138] ([194.73.73.138]:21426 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S131939AbRACATV>;
	Tue, 2 Jan 2001 19:19:21 -0500
Date: Tue, 2 Jan 2001 23:48:10 +0000 (GMT)
From: davej@suse.de
To: Hakan Lennestal <hakanl@cdt.luth.se>
cc: David Woodhouse <dwmw2@infradead.org>, Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <20010102183825.3C0904185@tuttifrutti.cdt.luth.se>
Message-ID: <Pine.LNX.4.21.0101022346540.23070-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Hakan Lennestal wrote:

> > The IBM DTLA drives aren't in the hpt366 bad_ata66_4 list still.
> 
> I second this ! 
> Until the hpt-problem is solved (if it ever will be)
> we really need the IBM DTLA drives in the bad-list.
> This configuration (IBM DTLA disks on hpt3* controller) can't be
> that unusual ?

Note, this seems to be hpt366 only, not hpt3**
I have two DTLA's on a HPT370 here in UDMA5, with no problems at all.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
