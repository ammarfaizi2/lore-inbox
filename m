Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262688AbSJEWG0>; Sat, 5 Oct 2002 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262696AbSJEWG0>; Sat, 5 Oct 2002 18:06:26 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:6540 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S262688AbSJEWGZ>;
	Sat, 5 Oct 2002 18:06:25 -0400
Date: Sat, 5 Oct 2002 17:10:58 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5 Problem Report Status
In-Reply-To: <200210052021.WAA04976@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0210051707550.13901-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Mikael Pettersson wrote:

> On Sat, 5 Oct 2002 11:57:59 -0500 (CDT), Thomas Molina wrote:
> >-------------------------------------------------------------------------
> >   open                   29 Sep 2002 IDE problems on prePCI
> >   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
> >
> >Mikael Pettersson <mikpe@csd.uu.se> reported this problem and proposed a 
> >patch.  Was the patch accepted, and did it fix the problem?
> 
> The patch was for minor subproblem, not the instant reboot problem.
> The reboot still occurs in 2.5.40.
> 
> Another issue: initrd appears to be broken since 2.5.38. See the
> "initrd breakage in 2.5.38-2.5.40" thread.


I misunderstood the timing of Al Viro's proposed fix for the problem.  I 
thought it was going in right away and the issue would be moot.  I've 
added it to my list.  Unfortunately, I'm getting connection refused 
messages when trying to connect to bkbits, so I'm unable to browse the 
comments like I usually do when researching this stuff.

