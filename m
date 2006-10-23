Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752000AbWJWQfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWJWQfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWJWQfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:35:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20461 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752000AbWJWQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:35:11 -0400
Subject: -rt7 announcement? (was Re: 2.6.18-rt6)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161356444.15860.327.camel@mindpipe>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 12:34:46 -0400
Message-Id: <1161621286.2835.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 11:00 -0400, Lee Revell wrote:
> On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> > i've released the 2.6.18-rt6 tree, which can be downloaded from the 
> > usual place:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> This does not work here.  It boots but then wants to fsck my disks, and
> dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booting
> 2.6.18-rt5 works and does not want to fsck the disks. 

I see that -rt7 is posted.  The patch is a huge diff from -rt6.  Where
are the release notes?

Lee

