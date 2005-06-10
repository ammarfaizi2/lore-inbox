Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVFJXAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVFJXAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVFJXAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:00:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65449 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261370AbVFJW7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:59:46 -0400
Subject: Flames go here (was Re: Attempted summary of "RT patch acceptance"
	thread)
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
In-Reply-To: <20050610225231.GF6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com>
	 <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com>
	 <20050610173728.GA6564@g5.random>
	 <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com>
	 <20050610223724.GA20853@nietzsche.lynx.com>
	 <20050610225231.GF6564@g5.random>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 19:00:39 -0400
Message-Id: <1118444440.6423.125.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 00:52 +0200, Andrea Arcangeli wrote:
> On Fri, Jun 10, 2005 at 03:37:24PM -0700, Bill Huey wrote:
> > Some of the comments from various folks are just intolerably paranoid
> 
> Just tell me how can you go to a customer and tell him that your
> linux-RTOS has a guaranteed worst case latency of 50usec.  How can you
> tell that? Did you exercise all possible scheduler paths with cache
> disabled and calculated the worst case latency with rdtsc + math?
> 
> Why do you take risks when you can go with much more relaible solutions
> like RTAI and rtlinux?

This thread is converging back to the original "RT patch acceptance"
thread.  I've changed the subject line so people can distinguish the
content from the flames.

Lee

