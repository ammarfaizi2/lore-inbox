Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVFABjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVFABjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFABjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:39:40 -0400
Received: from opersys.com ([64.40.108.71]:20233 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261201AbVFABji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:39:38 -0400
Message-ID: <429D1451.2060001@opersys.com>
Date: Tue, 31 May 2005 21:50:09 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Philippe Gerum <rpm@xenomai.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       "Bill Huey (hui)" <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>, Esben Nielsen <simlo@phys.au.dk>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random>	 <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk>	 <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com>	 <20050531204544.GU5413@g5.random>  <429D0C13.3000006@opersys.com> <1117589425.4749.22.camel@localhost.localdomain>
In-Reply-To: <1117589425.4749.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt wrote:
> This looks very interesting.  I need to read more into RTAI and friends
> when I get a chance.  I just received the latest Linux Journal that has
> the article about the use of RTLinux with the control of magnetic
> bearings.  I've just started reading it so I don't know all the details
> yet but it still looks very promising. 

I'll abstain from reviving any of the RTLinux vs. RTAI zombies, none of
those that attended are in any way eager to take those ones out of the
closet, but I would suggest some archive browsing. It is nevertheless,
safe to say that there a lot of differences between these projects, and
that both sides have a very different idea of what these differences are
and what they mean. Great care should be taken not to disturb the dead :)

> I don't think the adding of preempt-RT patch to the kernel will hurt
> anything. In fact I think it may even help out the RTAI and friends.
> Anyway, as it has been stated, this discussion has started too early.
> (Thanks Daniel ;-)

I've removed the disclaimer in my latest replies, but I stated very
early in this thread that the approaches are not mutually exclusive.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
