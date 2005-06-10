Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVFJDAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVFJDAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 23:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFJDAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 23:00:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2000 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261799AbVFJDAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 23:00:08 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
In-Reply-To: <20050609235026.GE1297@us.ibm.com>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com>  <20050609235026.GE1297@us.ibm.com>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 22:59:48 -0400
Message-Id: <1118372388.32270.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 16:50 -0700, Paul E. McKenney wrote:
> On Thu, Jun 09, 2005 at 04:34:11PM -0700, Tim Bird wrote:
> > Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Midway through the recent "RT patch acceptance" thread, someone mentioned
> > > that it might be good to summarize the various approaches.  The following
> > > is an attempt to do just this, with an eye to providing a reasonable
> > > framework for future discussion.
> > > 
> > > Thoughts?  Errors?  Omissions?
> > 
> > I haven't finished it, but it looks great so far.  Are you planning to
> > repost it to LKML, or otherwise publish it somewhere, after incorporating
> > feedback?
> 
> Glad you like it!
> 
> I figured on sending out an update sometime next week, after incorporating
> feedback.

I believe you are too friendly to vanilla + CONFIG_PREEMPT.  People are
still seeing tens or hundreds of ms bumps.

Does the LTP include an RT latency test yet?

Lee

