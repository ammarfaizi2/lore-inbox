Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310493AbSCCBBO>; Sat, 2 Mar 2002 20:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310494AbSCCBBE>; Sat, 2 Mar 2002 20:01:04 -0500
Received: from trillium-hollow.org ([209.180.166.89]:33983 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310493AbSCCBA5>; Sat, 2 Mar 2002 20:00:57 -0500
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: Your message of "Sat, 02 Mar 2002 18:31:03 EST."
             <20020302233103.GA3018@pimlott.ne.mediaone.net> 
Date: Sat, 02 Mar 2002 17:00:49 -0800
From: erich@uruk.org
Message-Id: <E16hKMr-0000yX-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Pimlott <andrew@pimlott.ne.mediaone.net> wrote:

> On Sat, Mar 02, 2002 at 12:31:48PM -0800, erich@uruk.org wrote:
> > My general contention is that the system should, by default, behave as
> > non-experts would expect, but this might be a point where we can't
> > agree.
> > 
> > It is, unfortunately, the cardinal rule when designing any usable
> > interfaces.  I reference Donald Norman's "The Design of Everyday
> > Things".  But I digress.
> 
> I must agree with Alan.  Low level technical interfaces should
> behave according to standards, and should follow a consistent logic
> understood by experts in the field (even if it is difficult for the
> beginner).  If people try to push "usability" (and I'm as much a fan
> of that book as you) onto kernel interfaces, we'll wade into a swamp
> and never get out.
> 
> Such interfaces need not be exposed to ordinary users.  Indeed, by
> keeping the low-level layer simple and orthogonal, it becomes easier
> to build multiple user-facing layers (for different purposes, or for
> comparison at the same purpose).  I think this principle is much
> more powerful than the one you advance.

You get no disagreement from me with the concept, and I'm following
a similar one in a system I'm working on now.  (as to the standards
conformance, look at my most recent email a few messages ago on
that...  we're arguing it out  ;-).

The Linux kernel at this point, however, is not so easy/orthogonal
as you claim, I think.  The question always arises:  If there is
no other easy way to do something than modify your low-level
technical interface, then what do you do?

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
