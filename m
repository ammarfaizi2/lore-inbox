Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbTACDYB>; Thu, 2 Jan 2003 22:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbTACDYB>; Thu, 2 Jan 2003 22:24:01 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:7835 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S264690AbTACDYA>; Thu, 2 Jan 2003 22:24:00 -0500
From: Richard Stallman <rms@gnu.org>
To: mark@mark.mielke.cc
CC: billh@gnuppy.monkey.org, paul@clubi.ie, riel@conectiva.com.br,
       Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org
In-reply-to: <20030102061430.GA23276@mark.mielke.cc> (message from Mark Mielke
	on Thu, 2 Jan 2003 01:14:30 -0500)
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Reply-to: rms@gnu.org
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org> <20030102061430.GA23276@mark.mielke.cc>
Message-Id: <E18UIZS-0006Cr-00@fencepost.gnu.org>
Date: Thu, 02 Jan 2003 22:32:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I regularly use several kernel modules that provide a GPL component that
    interfaces the module to the kernel, and a closed source object file that
    is dynamically loaded as a kernel module at run time.

    If I did not have these modules, I would not be able to use Linux as my
    host operating system.

Many enthusiasts the "Linux" operating system take the popularity of
the system (or of the kernel, Linux) as the supreme goal; but why
should the popularity of any one operating system or program be so
important?  That isn't what really matters.

We developed the GNU system for the sake of freedom, and freedom is
what really matters.  The GNU/Linux system today is important because
it offers a road to freedom.  But it doesn't guarantee you will arrive
there.  If you use non-free drivers, you go just part way along the
road and never arrive at freedom.  That defeats the purpose.  To
achieve freedom, we need to insist on free drivers (and free
applications).

Erik Andersen <andersen@codepoet.org> wrote:

    If nvidia provided non-functional GPL
    source code with all the proprietary 3rd party bits ripped out, 
    I would expect a hoard of developers would jump at the chance to
    fixup the non-functional mess, clean it up, reimplement all the
    missing proprietary bits.  I'd bet you $20 US we could have a
    functional driver within 2 weeks.

If NVidia cooperates with us this much, we should certainly pick up
the ball from there, and I am sure we will manage to go the rest of
the way.  But don't bet on 2 weeks.  Softare always takes twice as
long as you expect ;-).  If it takes a whole month month to be able to
use NVidia hardware in freedom, I won't complain about the delay.

But we could make do with even less cooperation than that.  If they
just provide the necessary specs to a person who wants to extend the
free drivers that exist, that would be sufficient.  It might take more
than 4 weeks to write the code, but surely not more than a few months.


