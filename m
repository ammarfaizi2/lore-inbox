Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbRDKReZ>; Wed, 11 Apr 2001 13:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132683AbRDKReO>; Wed, 11 Apr 2001 13:34:14 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:15590 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132682AbRDKRd7>; Wed, 11 Apr 2001 13:33:59 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE823@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Miles Lane'" <miles@megapathdsl.net>,
        Matti Aarnio <matti.aarnio@zmailer.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: RE: 2.5 module development mailing list needed?  [Fwd: Linux Secu
	rity Module Interface]
Date: Wed, 11 Apr 2001 10:33:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	Proper place to do this discussion is 
> linux-kernel@vger.kernel.org
> 
> It sounds good in theory.  In practice, though, almost all of the
> design discussions have been occuring in private e-mail.
> For example, I have seen none of the messages discussing
> the changes planned for the power management stuff in 2.5,
> even though these changes will apparantly touch every single
> modular driver.  I know for a fact that the changes planned
> to enable better implementation of PCMCIA support have
> gone on between only a few developers.  Also, from the
> announcement from the Security Module folks, I gather that
> there discussions haven't been held on LKML and aren't
> planned to migrate here.

IMO, the non-LKML lists exist so that developers can go off and have long,
boring, highly technical discussions without everyone having to wade through
it. It's not private email, it's just another list. So, subscribe, or look
at the archives. Most people don't care about this stuff, so the ones that
do should opt-in to whatever list.

> So, if you really think that all these module-related design
> discussions should happen on LKML, we're going to have
> to convince a bunch of people to move their discussions
> here.  This will not necessarily be easy.  I know that the
> reason that many of these discussions occur between only
> a few people is that these folks want a decent signal to
> noise ratio.  That's why I proposed a "2.5-module-devel"
> list.  It would allow people who really care about this stuff
> to coordinate their work.

I am not positive that your initial premise is entirely correct. For
example, it's way too early to say definitively, but right now I don't see
ACPI or power management requiring any changes to the module architecture.
(Driver arch maybe, but not module arch)

So, maybe you should just copy the two lists (hotplug and security) in
question?

Regards -- Andy

