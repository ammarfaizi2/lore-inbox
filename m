Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275868AbSIUD3F>; Fri, 20 Sep 2002 23:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275872AbSIUD3F>; Fri, 20 Sep 2002 23:29:05 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64520
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S275868AbSIUD3D>; Fri, 20 Sep 2002 23:29:03 -0400
Date: Fri, 20 Sep 2002 20:30:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
In-Reply-To: <200209210214.g8L2EFE18681@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10209202019430.25090-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Pete Zaitcev wrote:

> > Obvious this is a way for the telecom folks to get something for free that
> > really should be paid for by funding the project with CASH.  Or funding
> > (a) startup(s) related to generating such support.
> 
> Andre, if I read you right, you are articulating the following
> idea: "Those guys collect drivers written by students and try
> to run them in production. Of course, it cannot work. If paid
> professionals wrote them, there would be no problem."

You can read that into it sure, how about reading the other side.
Also Pete, you know me better than to paint me into that corner so bogus.
Treat the students as professionals, as they will be soon enough.

Sheesh, fund a university project to get the fresh young minds to derive
the future fabric.  Regardless if the students are paid or offerred
scholarships in return, would it not be a "WIN-WIN" for "ALL"?
Now the cherry on top comes to a few or many who are super talented, and
find they have a career resulting from the work.

> If this is what you are saying here, it is very misguided.
> I had a chance to examine some of drivers written by paid
> professionals, and the picture was pretty bleak. Also, the
> problem of hardening is not unique to Linux or Open Source,
> I had runs with it before.
> 
> So, I do not think there's a budgetary issue here. I talked to
> the C-G Linux folks at OLS, and they do have funding. But I do

So if this is true, where is the sign up list for contracts based on
deliverables?  

> not think the hardening is going to fly the way they push it,
> for two technical reasons.
> 
>  First, you cannot race crappy driver writers. As soon as you
> harden and qualify something, technology changes and brings
> a whole bunch of crappy drivers.

No but a legal binding contract of deliverables will bring those along who
rise to the challenge, correct?

>  Second, the resulting "hardened" system is no less fragile than
> it was before.

Erm, more likely the basic infrastucture for permiting in-band device
recovery and communication pathways back to the requesting thread or
application above is what appears to be lacking, but then again I could be
wrong.

> If I was going the C-G Linux, I would abandon the "hardening"
> efforts as they are now, and shift in-house hackers to work on
> clusters and UML (including a cluster or UMLs).
> 
> As far as giving goes, the C-G people expended a lot of effort
> on documentation of their wishes (again, judging by their OLS
> performance). And I mean *A F. LOT* of effort. If they
> coded as much as they wrote reports and reviews, we'd probably
> have something working by now.

Nice, so they do a great dog-n-pony show?

Cheers,

Andre Hedrick
LAD Storage Consulting Group

