Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267820AbTAHPRD>; Wed, 8 Jan 2003 10:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbTAHPRD>; Wed, 8 Jan 2003 10:17:03 -0500
Received: from fluent2.pyramid.net ([206.100.220.213]:56712 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S267820AbTAHPRB>; Wed, 8 Jan 2003 10:17:01 -0500
Message-Id: <5.2.0.9.0.20030108065119.01d69ab0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 08 Jan 2003 07:25:37 -0800
To: Andre Hedrick <andre@linux-ide.org>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Honest does not pay here ...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10301080249330.421-100000@master.linux-ide.o
 rg>
References: <Pine.LNX.4.43.0301081058320.28725-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:05 AM 1/8/03 -0800, Andre Hedrick wrote:
>I have pissed off everyone.
>While searching for the exact line of where things are black and white.
>Nobody cares enough to help clear the air.
>Nobody cares to pursue any of the existing binary modules.

Well, Andre, you haven't pissed me off in any way, sir.  You have raised 
some very interesting questions, questions that need to be answered if 
Linux is going to continue to live in the real world.  Real world, as 
opposed to the Utopia (or Utopias) that some contributor here would like to 
see.

This is for the rest of you:

I'm not knocking the sincerity of those contributors who have made their 
views known on this subject, nor do I want to disabuse them of their 
dream.    I want them, though, to recognize the dream for what it is, goals 
that would be nice to achieve but not a reality no matter how much they may 
wish it so.  Goals that have merit, as long as they don't become a 
straitjacket to making Linux useful to its users.

The concept of a kernel "tainted" by binary-only modules was, as I recall 
the prior threads on the subject, was focused on preventing developers from 
"spinning their wheels" trying to debug a black box for which no source is 
available and which may have unintended and astonishing effects on the rest 
of the kernel.  In this goal, the Linux Developer Community has followed in 
the footsteps of Microsoft Corporation, in wanting to focus their support 
efforts on situations where the variables are minimized.

-->  The whole purpose of Microsoft's Windows Hardware Certification Lab 
(WHCL) process was to ensure that hardware and the drivers that come with 
them meet certain minimum performance and configuration parameters, 
reducing Microsoft's technical support triage efforts.

-->  The whole purpose of the "tainted" kernel indication was to ensure 
that a problem report involving black boxes indicate that black boxes are 
involved, reducing the Linux Developer Community's technical support triage 
efforts.

Sauce for the goose is sauce for the gander.

The contributors who champion "free (as in speech) software" must recognize 
that the concept of intellectual property is a global concept, not just the 
child of one country such as the United States.  Limiting customer choice 
by blocking closed-source binary-only drivers only serves to make Gnu/Linux 
(ok, Stallman?) less useful to our customers because it does eliminate a 
choice.  I applaud the goal of emphasizing open-source drivers where open 
source is possible.  Just as the holder of a hammer tends to look at all 
problems as nails, some of the contributors here appear to think  that 
open-source is the be-all and end-all -- but the real world of intellectual 
property royalties and cutthroat competition sometimes makes open source 
impractical or impossible.

I want to make this clear:  if the customer requirements are such that s/he 
need to use hardware with a closed-source driver, then it is the customer's 
choice to incorporate said hardware and drivers.  The problem that some 
contributors to this discussion on LKML are trying to create an environment 
that  is specifically intended to rob the customer of that choice in the 
pursuit of a dream, a dream that WILL force that customer to a different 
solution other than Linux.

That's bad for Linux, that's bad for GNU, that's bad for the customer the 
Linux user.

You DO believe that we should be looking out for the Linux user, don't you?

Educate.  Don't dictate.

OK, now the coffee should be ready, and I can medicate myself.

Stephen Satchell


-- 
The human mind treats a new idea the way the body treats a strange
protein:  it rejects it.  -- P. Medawar
This posting is for entertainment purposes only; it is not a legal opinion.

