Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135199AbRDYNfw>; Wed, 25 Apr 2001 09:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbRDYNfm>; Wed, 25 Apr 2001 09:35:42 -0400
Received: from [208.204.44.103] ([208.204.44.103]:46605 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S135199AbRDYNfc>; Wed, 25 Apr 2001 09:35:32 -0400
Date: Wed, 25 Apr 2001 07:37:24 -0500 (CDT)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: USB/Reboot
In-Reply-To: <E14sAZB-00030T-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10104250735390.28677-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not familiar with that option, where would I be setting it? Or even
better, where is it documented?

I'll inform server works of this problem.

Thanks,
Jay

On Tue, 24 Apr 2001, Alan Cox wrote:

> > If USB is disabled on a server works MB reboots hang in 2.2.x
> 
> In almost all cases a hang after Linux reboots the system and it not coming
> back to the BIOS is a BIOS bug.
> 
> You can confirm this by asking the kernel to do a real bios reboot with
> the reboot= option
> 

