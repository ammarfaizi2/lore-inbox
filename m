Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284304AbRLRRQv>; Tue, 18 Dec 2001 12:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284302AbRLRRQk>; Tue, 18 Dec 2001 12:16:40 -0500
Received: from [206.40.202.198] ([206.40.202.198]:5988 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S284289AbRLRRQb>; Tue, 18 Dec 2001 12:16:31 -0500
Date: Tue, 18 Dec 2001 09:12:43 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <E16GKvk-0007Sc-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1011218091159.581e-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Alan Cox wrote:

> Date: Tue, 18 Dec 2001 14:09:16 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Rik van Riel <riel@conectiva.com.br>,
>     Davide Libenzi <davidel@xmailserver.org>,
>     Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Scheduler ( was: Just a second ) ...
> 
> > to CD-RW disks without having to know about things like "ide-scsi" etc,
> > and do it sanely over different bus architectures etc.
> > 
> > The scheduler simply isn't that important.
> 
> The scheduler is eating 40-60% of the machine on real world 8 cpu workloads.
> That isn't going to go away by sticking heads in sand.

What % of a std 2 cpu, do you think it eats?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

