Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284136AbRLAQLO>; Sat, 1 Dec 2001 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLAQLL>; Sat, 1 Dec 2001 11:11:11 -0500
Received: from bitmover.com ([192.132.92.2]:24003 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284140AbRLAQK0>;
	Sat, 1 Dec 2001 11:10:26 -0500
Date: Sat, 1 Dec 2001 08:10:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: Mark Frazer <mark@somanetworks.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011201081025.K19152@work.bitmover.com>
Mail-Followup-To: Mark Frazer <mark@somanetworks.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <E169scn-0000kt-00@starship.berlin> <20011130110546.V14710@work.bitmover.com> <E169vcF-0000lQ-00@starship.berlin> <E169vcF-0000lQ-00@starship.berlin> <20011130155740.I14710@work.bitmover.com> <20011201022157.38ed90b5.skraw@ithnet.com> <20011201110430.A4737@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011201110430.A4737@somanetworks.com>; from mark@somanetworks.com on Sat, Dec 01, 2001 at 11:04:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 11:04:30AM -0500, Mark Frazer wrote:
> Stephan von Krawczynski <skraw@ithnet.com> [01/11/30 20:27]:
> > 4) Warning, this is the hard stuff!
> > Ok, so you are fond of SUN. Well, me too. But I am not completely blind, not
> > yet :-) So I must tell you, if Solaris were the real big hit, then why its
> > Intel-Version is virtualy been eaten up on the market (the _buying_ market out
> > there) by linux?
> 
> I can't say for the O/S buying market.  But I do embedded (pretty large
> embedded systems but embedded nonetheless) development and we walked away
> from Solaris after comparing the complexity of our first network drivers.
> 
> STREAMS:  just say no.

Amen to that.  STREAMS would be one of the strongest arguments in favor
of Linus' theory that evolution takes care of it.  STREAMS were done at
Sun by some "architects" who thought they would be better than sockets.
Linus is dead right, on this sort of issue, Linux responds quickly and 
weeds out the crap.  We still have some room for discussion on the 
design issues, but yeah, Sun blew it on this one and refused to admit it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
