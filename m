Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269332AbUJKXHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269332AbUJKXHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269335AbUJKXDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:03:37 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:24299 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269341AbUJKXCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:02:42 -0400
Date: Mon, 11 Oct 2004 15:58:31 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: ricklind@us.ibm.com, mbligh@aracnet.com, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041011155831.3e8d6b2f.pj@sgi.com>
In-Reply-To: <1097532415.4038.50.camel@arrakis>
References: <20041007072842.2bafc320.pj@sgi.com>
	<200410071905.i97J57TS014336@owlet.beaverton.ibm.com>
	<20041009191556.06e09c67.pj@sgi.com>
	<1097532415.4038.50.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> One of the cool thing about using sched_domains as your partitioning
> element is that in reality, tasks run on *CPUs*, not *domains*. 

Unfortunately, my manager has reminded me of an essential deliverable
that I have for another project, due in two weeks.  I'm going to need
every one of those days.  So I will have to take a two week sabbatical
from this design work.

It might make sense to reconvene this work on a new thread, with a last
message on this monster thread inviting all interested parties to come
on over.  I suspect a few folks will be happy to see this thread wind
down.

I'd guess lse-tech (my preference) or ckrm-tech would be a suitable
forum for this new thread.

Carry on.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
