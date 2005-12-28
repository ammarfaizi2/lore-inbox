Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVL1CRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVL1CRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 21:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVL1CRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 21:17:52 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:51929 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932445AbVL1CRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 21:17:51 -0500
Subject: Re: 2.6.14-rt22 (and mainline): netstat -anop triggers excessive
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
References: <1135145065.29182.10.camel@mindpipe>
	 <1135204629.14810.43.camel@localhost.localdomain>
	 <1135732888.22744.51.camel@mindpipe>
	 <Pine.LNX.4.58.0512272110490.10936@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 21:22:42 -0500
Message-Id: <1135736563.22744.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 21:11 -0500, Steven Rostedt wrote:
> On Tue, 27 Dec 2005, Lee Revell wrote:
> 
> > > [snip]
> > >
> > > So it really does improve the latency here.  Now is this worth the
> > > overhead?  This might be useful in other places to.
> >
> > Any chance you can regenerate the patch against 2.6.15-rc5-rt4?
> >
> 
> Sure, if I can find the damn thing.  Too many kernels, and too many patch
> directories.

Never mind, I applied it by hand.  I'll let you know how it works.

Lee

