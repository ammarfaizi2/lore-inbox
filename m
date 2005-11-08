Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVKHSpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVKHSpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVKHSpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:45:10 -0500
Received: from serv01.siteground.net ([70.85.91.68]:58316 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030296AbVKHSpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:45:09 -0500
Date: Tue, 8 Nov 2005 10:45:05 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Cleanup bootmem allocator and fix alloc_bootmem_low
Message-ID: <20051108184505.GB3733@localhost.localdomain>
References: <20051108073224.GA3753@localhost.localdomain> <20051108224621.7062.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108224621.7062.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yasunori-san,

On Tue, Nov 08, 2005 at 11:24:12PM +0900, Yasunori Goto wrote:
> 
> I guess your patch is for 2.6.14-git11, right?

Yes, it was on top of the latest git as of the patch creation.

> I tried it on my ia64 Tiger4 with NUMA emulation.
> This emulation had worked well so far.
> 
> But, 2.6.14-git11 doen't boot even if your patch is not used.
> (Probably, it is caused by changing efi_map walker.)
> 
> And I can't use our big true NUMA machine now.
> It is used by other person. So, I have to reserve it to use again.
> 
> If I can test it, I'll notify about it ASAP.

'Appreciate the feedback.  Do let me know how it goes.

Thanks,
Kiran
