Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWDHDBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWDHDBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 23:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWDHDBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 23:01:37 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23706 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965000AbWDHDBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 23:01:37 -0400
Subject: Re: RT task scheduling
From: Steven Rostedt <rostedt@goodmis.org>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20060407233631.GA17574@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com>
	 <200604070756.21625.darren@dvhart.com>
	 <20060407210633.GA15971@gnuppy.monkey.org>
	 <200604071537.38044.dvhltc@us.ibm.com>
	 <20060407233631.GA17574@gnuppy.monkey.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 23:01:22 -0400
Message-Id: <1144465282.30689.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

I'm just catching up on this thread.  Is your main concern that a High
prio task is going to be unnecessary delayed because there's a lower RT
task on the same CPU and time is needed to push it off to another CPU?
It's late, so forgive me if this is a stupid question ;)


On Fri, 2006-04-07 at 16:36 -0700, Bill Huey wrote:

> > Has this cleared some things up?  If not, let me know what else needs 
> > clarification.
> 
> Yes, but you should really work to clarify terminology. Is this better ?

Goes both ways :)

-- Steve

PS. It's really good to see you back on LKML.  I've missed your posts.


