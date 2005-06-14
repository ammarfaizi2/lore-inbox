Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVFNTPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVFNTPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVFNTP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:15:29 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:14086 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261296AbVFNTPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:15:22 -0400
Date: Tue, 14 Jun 2005 12:20:56 -0700
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: karim@opersys.com, "Bill Huey (hui)" <bhuey@lnxw.com>, dwalker@mvista.com,
       paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050614192056.GA2985@nietzsche.lynx.com>
References: <42AE0EF8.1090509@opersys.com> <E1DiETa-000450-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DiETa-000450-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 09:41:22AM -0700, Gerrit Huizenga wrote:
> Everyone scratches their own itches - and if a vendor doesn't *become*
> a member of the community, including understanding the ground rules, the
> motivators and de-motivators, and does not become an advocate for those
> community goals, they will always be on the outside looking in.
...

I agree. You're one of the few folks from IBM and other large companies
to understand this. There's a real lack of technical leadership in this
community and it is a fear of change in general as well as to this patch
because of what seem to be an inability to think through various problems
like this and be comfortable with it. That's why I went to FreeBSD for a
while since the Linux VM system back in the day was doing nothing be
thrashing. Even in 2005 it's still got problems relative to the BSDs for
load handling it seems and this why I still track projects like DragonFly
BSD since they are much more friendly to heavy design changes unlike Linux.

> While this is a statement of what is happening, I think it is also an
> important statement about what needs to happen for the RT community to
> become part of the mainline development community.  Until you have been
> subverted, you are going to keep talking about how to advocate *your*
> agenda.  You need to advocate the *communities'* agenda, as a member of
> the subverted community who holds onto *all* of the major driving forces
> and goals for Linux.

In my case, I was already subverted by Linux and other open source projects.
I just happen to get hired by an RTOS vendor to continue this work in some
way.
 
> It's easy:
> 
> 	1) Change your allegiance to Linux first
> 	2) Do the right thing.
> 
> And, implicit in that is that I believe that RT for the community will
> in the long term be The Right Thing.

This implications of this patch are huge. It's transparent and will ultimately
change the userspace land scape for just about everything despite the paranoia
and disinformation spread by various arch-conservatives in this community.

bill

