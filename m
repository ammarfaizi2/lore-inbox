Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbSLTAQT>; Thu, 19 Dec 2002 19:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLTAQS>; Thu, 19 Dec 2002 19:16:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57049 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267173AbSLTAQR>; Thu, 19 Dec 2002 19:16:17 -0500
Date: Thu, 19 Dec 2002 19:24:19 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
Message-ID: <20021219192419.A11997@devserv.devel.redhat.com>
References: <200212192155.gBJLtV6k003254@darkstar.example.net> <3E0240CA.4000502@inet.com> <mailman.1040338801.24520.linux-kernel2news@redhat.com> <200212192359.gBJNxUI09113@devserv.devel.redhat.com> <62590000.1040343543@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <62590000.1040343543@w-hlinder>; from hannal@us.ibm.com on Thu, Dec 19, 2002 at 04:19:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 19 Dec 2002 16:19:03 -0800
> From: Hanna Linder <hannal@us.ibm.com>

> >> Why are bugs automatically assigned to owners? 
> >> 	If there was an unassigned category that would make it 
> >> 	easy to query.
> > 
> > Query for "NEW" status for a component and do not put anything
> > into "owner" fireld.
> 
> 	If there was a NEW field that would be exactly what I was 
> asking for. When I do a query the only options I see are: OPEN, 
> ASSIGNED, RESOLVED, APPROVED, REJECTED, DEFERRED, CLOSED. 
> Where is the NEW? Is there somewhere else to do queries?

OK, I'm sorry. This is a little different from what we have at
bugizlla.redhat.com. I suspect OSDL's OPEN roughly corresponds
to NEW. They appear to use Bugzilla which closely resembles the
mother of all them at Mozilla.

> >> Also a list of people who arent maintainers but are available to help 
> >> 	could be useful for the owners to assign bugs to.
> > 
> > That's putting a cart in front of a horse. Such people have
> > to execute a simple Bugzilla to get lists, then select bugs
> > which they like. This way the overhead of maintaining such
> > lists disappears instantly.
> 
> Im trying to help make it easier for such people to get a list
> of bugs to start working on. If it looks like everything already
> has an owner it looks like there is nothing to do. Im just trying
> to figure out how to use it and hopefully help other people
> do the same thing.

I see the point. I would say, having an owner does not mean
much. Owner is just a person who makes sure bugs do not get lost.
You can work on my bugs if you'd like :)

I understand now that I carry a whole load of misconceptions
caused by extensive use of a slighly different process at Red Hat.
Perhaps we ought to tap into Mozilla people expirience.

-- Pete
