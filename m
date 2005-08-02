Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVHBPjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVHBPjt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVHBPjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:39:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:18568 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261570AbVHBPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:38:59 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122992426.1590.11.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe>
	 <20050731063852.GA611@elte.hu>  <1122871521.15825.13.camel@mindpipe>
	 <1122991018.1590.2.camel@localhost.localdomain>
	 <1122991531.5490.27.camel@mindpipe>
	 <1122992426.1590.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 11:38:57 -0400
Message-Id: <1122997137.11253.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 10:20 -0400, Steven Rostedt wrote:
> > Are you in any position to do a binary search?  It would be really
> bad
> > to release 2.6.13 with this problem...
> 
> Unfortunately no. I'm trying to finish a milestone that was due last
> Friday, debug a problem that was found on my last milestone, and add a
> feature to Ingo's RT patch. So I can't get to this till at earliest
> next
> week.

OK I have time to try -rc1 then -rc2, hopefully this will nail it down.

Lee

