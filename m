Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUJLVX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUJLVX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUJLVX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:23:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25570 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267841AbUJLVXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:23:45 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041011155831.3e8d6b2f.pj@sgi.com>
References: <20041007072842.2bafc320.pj@sgi.com>
	 <200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
	 <20041009191556.06e09c67.pj@sgi.com> <1097532415.4038.50.camel@arrakis>
	 <20041011155831.3e8d6b2f.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097616152.6239.4.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 12 Oct 2004 14:22:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 15:58, Paul Jackson wrote:
> Matthew wrote:
> > One of the cool thing about using sched_domains as your partitioning
> > element is that in reality, tasks run on *CPUs*, not *domains*. 
> 
> Unfortunately, my manager has reminded me of an essential deliverable
> that I have for another project, due in two weeks.  I'm going to need
> every one of those days.  So I will have to take a two week sabbatical
> from this design work.
> 
> It might make sense to reconvene this work on a new thread, with a last
> message on this monster thread inviting all interested parties to come
> on over.  I suspect a few folks will be happy to see this thread wind
> down.
> 
> I'd guess lse-tech (my preference) or ckrm-tech would be a suitable
> forum for this new thread.
> 
> Carry on.

Sounds good, Paul.  I think the discussion on this thread was kind of
winding down anyway.  In two weeks I'll have some more work done on my
code, particularly trying to get the cpusets/CKRM filesystem interface
to play with my sched_domains code.  We'll be able to digest all the the
information, requirements, requests, etc. on this thread and start a
fresh discussion on (or at least closer to) the same page.

-Matt

