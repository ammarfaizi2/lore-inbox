Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVHaPbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVHaPbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVHaPbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:31:52 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16881 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964843AbVHaPbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:31:51 -0400
Subject: Re: [FYI] 2.6.13-rt3  and a nanosleep jitter test.
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1125501552.5714.14.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
	 <1125023010.5365.4.camel@localhost.localdomain>
	 <1125064334.5365.39.camel@localhost.localdomain>
	 <1125414039.5675.42.camel@localhost.localdomain>
	 <1125417156.6355.13.camel@localhost.localdomain>
	 <1125500514.5714.12.camel@localhost.localdomain>
	 <1125501220.28697.7.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1125501552.5714.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 08:30:06 -0700
Message-Id: <1125502206.28697.13.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No problem .. There are some other tests in there though .. I've been
using them for stress testing .. Apparently you don't need HRT on to use
them either.

Daniel

On Wed, 2005-08-31 at 11:19 -0400, Steven Rostedt wrote:
> On Wed, 2005-08-31 at 08:13 -0700, Daniel Walker wrote:
> > Sorry, that's http://high-res-timers.sf.net/
> 
> Thanks,
> 
> But I always seem to prefer to rewrite the wheel than to use one that
> already exists. ;-)  Probably explains why my cars are always in the
> shop!
> 
> -- Steve
> 
> 

