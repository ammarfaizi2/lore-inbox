Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266818AbSKOWSW>; Fri, 15 Nov 2002 17:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266826AbSKOWSV>; Fri, 15 Nov 2002 17:18:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16066 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266818AbSKOWST>; Fri, 15 Nov 2002 17:18:19 -0500
Date: Fri, 15 Nov 2002 14:22:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <467166910.1037370147@[10.10.2.3]>
In-Reply-To: <20021115.133004.65979948.davem@redhat.com>
References: <20021115.133004.65979948.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm more concerned about the inevitable explosion of duplicates
> and "fixed already"'s.
> 
> This is why a lot of people warned early on, and were wary about,
> having someone full time managing and watching over this bug database.
> It is specifically to deal with dups and things of this nature.
> 
> I don't want to be concerned about spending each morning closing a
> screenful of dups or "fixed already" reports.  Then the bug database
> isn't helping me, it's rather making more work for me.
> 
> This work is someone else's job.  On linux-kernel, we have a "someone
> else" to do this already, the entire readership of linux-kernel. :-)
> 
> In bugzilla however, all of this work now must be done by whoever at
> OSDL is watching over the bugzilla database all day long and _ME_.
> That is an inefficient use of resources.

OK, the easy way to fix this is to change the default owner for the
category to someone else who can filter the bugs as they arrive in
"OPEN" state. After filtering, they can be moved to "ASSIGNED" state,
and the owner changed to you ... how does that sound?

M.

