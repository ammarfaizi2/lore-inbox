Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVL1CL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVL1CL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVL1CLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:11:55 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45022 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932442AbVL1CLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:11:55 -0500
Date: Tue, 27 Dec 2005 21:11:46 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
 latencies
In-Reply-To: <1135732888.22744.51.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
References: <1135145065.29182.10.camel@mindpipe>  <1135204629.14810.43.camel@localhost.localdomain>
 <1135732888.22744.51.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2005, Lee Revell wrote:

> > [snip]
> >
> > So it really does improve the latency here.  Now is this worth the
> > overhead?  This might be useful in other places to.
>
> Any chance you can regenerate the patch against 2.6.15-rc5-rt4?
>

Sure, if I can find the damn thing.  Too many kernels, and too many patch
directories.

-- Steve

