Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267379AbTACEwM>; Thu, 2 Jan 2003 23:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTACEwM>; Thu, 2 Jan 2003 23:52:12 -0500
Received: from codepoet.org ([166.70.99.138]:2709 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S267379AbTACEwL>;
	Thu, 2 Jan 2003 23:52:11 -0500
Date: Thu, 2 Jan 2003 22:00:42 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Larry McVoy <lm@work.bitmover.com>, Richard Stallman <rms@gnu.org>,
       mark@mark.mielke.cc, billh@gnuppy.monkey.org, paul@clubi.ie,
       riel@conectiva.com.br, Hell.Surfers@cwctv.net,
       linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Message-ID: <20030103050042.GA5123@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Larry McVoy <lm@work.bitmover.com>, Richard Stallman <rms@gnu.org>,
	mark@mark.mielke.cc, billh@gnuppy.monkey.org, paul@clubi.ie,
	riel@conectiva.com.br, Hell.Surfers@cwctv.net,
	linux-kernel@vger.kernel.org
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org> <20030102061430.GA23276@mark.mielke.cc> <E18UIZS-0006Cr-00@fencepost.gnu.org> <20030103040612.GA10651@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030103040612.GA10651@work.bitmover.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 02, 2003 at 08:06:12PM -0800, Larry McVoy wrote:
> On Thu, Jan 02, 2003 at 10:32:30PM -0500, Richard Stallman wrote:
> > But we could make do with even less cooperation than that.  If they
> > just provide the necessary specs to a person who wants to extend the
> > free drivers that exist, that would be sufficient.  
> 
> Yeah, if only the company that has invested millions in trying to scratch
> out a place to stand, if only they would give us their intellectual
> property for free, if only, why then we could steal that IP and give it
> to other people.  And it would take us less time to do it if they would
> only cooperate.  Why won't they cooperate?
> 
> How dare they not give of the fruits of their labors for free.

Unless I am terribly mistaken, Nvidia is a _hardware_ company.
Their IP is a piece of silicon, fans, connectors, and resistors
that you go to the store and _buy_.  If you go visit pricewatch,
it becomes immediately clear they are certainly not giving away
their graphics cards for free.  No one (not even rms) would
expect them to give away their hardware for free.  It takes money
to design and produce such products, and they deserve a fair
chance to make $$$ for their efforts.

If they are worried their competitors might try to do the same
nifty things with competing hardware, they should patent the
methods used by their nifty 3D hardware.  And if you go take a
look, Nvidia has done exactly that.  They have a big pile of
patents protecting their hardware and 3D methods from being
ripped off.  I'll leave my usual rant on software and algorithm
patents for another day, but given their pile of patents, I
expect any driver specs and software they release would be
useless to anyone but those that have purchased the right to use
their IP (by buying one of their cards).  So how exactly do they
lose by giving out the details needed for proper drivers, or by
providing source under the GPL?

I can see your arguments above as perhaps relevant to a software
company (cough, BK, cough), but this is not relevant to a hardware
company like Nvidia.  Unless their hardware is just an expensive
placebo, and they really do _everything_ in software (dunno)?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
