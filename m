Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVBRSgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVBRSgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVBRSgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:36:49 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:5819 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261433AbVBRSgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:36:46 -0500
Message-ID: <4075.10.10.10.24.1108751663.squirrel@linux1>
In-Reply-To: <20050218162729.GA5839@thunk.org>
References: <seanlkml@sympatico.ca>
    <4912.10.10.10.24.1108675441.squirrel@linux1>
    <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
    <1451.10.10.10.24.1108713140.squirrel@linux1>
    <20050218162729.GA5839@thunk.org>
Date: Fri, 18 Feb 2005 13:34:23 -0500 (EST)
Subject: Re: [BK] upgrade will be needed
From: "Sean" <seanlkml@sympatico.ca>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Chris Friesen" <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, February 18, 2005 11:27 am, Theodore Ts'o said:

> If you truly believe that BK would be able to add the value that it
> does to the kernel development process by using some other SCM as the
> master SCM, with BK being "underneath", as you proposed earlier, then
> you do not understand why BK is fundamentally better than the current
> open source SCM systems that are out there.

BK already feeds patches out at the head, surely if it's as powerful as
you think, it could feed a free SCM too for your non-bk friends in the
community.

> And people *can* use the tools of their choice today.  They can use
> CVS, and diff+patch, and suffer with all of the limitations that those
> tools have today.  And for people who are doing stuff around the
> periphery, quilt is often really the best tool for them.

The situation could be improved for these other tools if there wasn't so
much BK zealotry from those that use it.

> If it's about the whole ***kernel*** development community, then it's
> pretty clear that the current system works quite well.  All of the
> complaints have been coming primarily from SCM hackers, it seems, and
> not people who truly need the power of more powerful than downloading
> the bk snapshots, using the CVS export tree, and in the case where
> they need to look at the changes in a single changeset bkbits.net.

There's no technical reason for this limitation.

> The "cost" of using BK seems to be primarily more theoretical, and
> ideological, than real.  It's always seems to be about someone
> kvetching that they want to use SVN and get finely grained changsets
> through SVN, and they can't.  But how often does that happen, and
> what's so painful of getting the finely grained changeset through
> bkbits.net?  Not very.  So at the end of the day, it finally boils
> down to being all about ideology, doesn't it?

No.  It's just that the cost isn't being paid by you, so you don't care.


Cheers,
Sean.


