Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVFJWdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVFJWdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVFJWdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:33:20 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:36106 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261299AbVFJWbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:31:48 -0400
Date: Fri, 10 Jun 2005 15:37:24 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Andrea Arcangeli <andrea@suse.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610223724.GA20853@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A9F788.2040107@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 04:26:48PM -0400, Karim Yaghmour wrote:
> Bill, I know PREEMPT_RT is something you root for strongly. FWIW, however,
> such statements are usually counter-productive.

Some of the comments from various folks are just intolerably paranoid
and I'm frustrated by that.

> The existence of real-time monolithic kernels is not disputed. Note, though,
> that LynxOS is controlled by a single corporation and its development
> model could not be compared in any way to Linux. Because of Linux's

Well, as a dude that hangs with the LynxOS engineering staff in cubicals
next to me, I can say that development here is really no different than
any other kernel community that I've run into, open or closed. We're all
kernel engineers except with maybe a difference in emphasis on what is
important at any given time.

> development model, what others are attempting to explain (Andrea included,
> I think), the reality is that the auditing/upgrading you speak of is unlikely
> to ever become part of the development philosophy.

But it already has. This RT group doesn't need the whole community to jump
on it. We can do it ourselves and submit the changes to an upstream trees
where relevant.
 
> I don't contest the fact that those promoting PREEMPT_RT intend to conduct
> this auditing for the drivers that are of interest to their development.

Yeah, but that's just you and folks that have been friendly to this effort.
The rest is another story altogether.

> That, though, doesn't mean that those who are maintaining existing driver
> sets want to take part in that.

bill

