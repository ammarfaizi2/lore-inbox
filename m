Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbVJGOPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVJGOPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVJGOPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:15:34 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:8149 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S932662AbVJGOPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:15:34 -0400
Date: Fri, 7 Oct 2005 18:15:32 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20051007141532.GA24924@tentacle.sectorb.msk.ru>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200510071431.47245.ak@suse.de>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.11-ac7
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 02:31:46PM +0200, Andi Kleen wrote:
> > I too have a box that shows the symptoms from bugzilla entry above.
> > The system is Asus A8V Deluxe MB with
> > "AMD Athlon(tm) 64 X2 Dual Core Processor 3800+".
> >
> > The patch below did not fix the problem, while "idle=poll" did.
> > Hope this helps, dmesg attached.
> 
> Are you running the latest BIOS?

Well, I think not.
Asus file download page is unavailable since yesterday.

> 
> -Andi
> 
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

