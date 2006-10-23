Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWJWS5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWJWS5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWJWS5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:57:07 -0400
Received: from www.osadl.org ([213.239.205.134]:58597 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965013AbWJWS5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:57:06 -0400
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161629344.3982.6.camel@mindpipe>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <1161629344.3982.6.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 20:58:11 +0200
Message-Id: <1161629891.22373.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 14:49 -0400, Lee Revell wrote:
> > > I see that -rt7 is posted.  The patch is a huge diff from -rt6.  Where
> > > are the release notes?
> > 
> > Basically we merged the latest hrt-dyntick queue into -rt.
> 
> Thanks.  -rt7 boots and seems to work on this machine where -rt6 did
> not.
> 
> Is the bug where the NMI watchdog caused lockups thought to be fixed?

Yep,

	tglx


