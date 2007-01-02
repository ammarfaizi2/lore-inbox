Return-Path: <linux-kernel-owner+w=401wt.eu-S964853AbXABM52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbXABM52 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbXABM52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:57:28 -0500
Received: from thunk.org ([69.25.196.29]:34045 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbXABM51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:57:27 -0500
Date: Tue, 2 Jan 2007 07:50:26 -0500
From: Theodore Tso <tytso@mit.edu>
To: Trent Waddington <trent.waddington@gmail.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
Message-ID: <20070102125026.GA4608@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Trent Waddington <trent.waddington@gmail.com>,
	Bernd Petrovitsch <bernd@firmix.at>,
	"Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Giuseppe Bilotta <bilotta78@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <4587097D.5070501@opensound.com> <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net> <200612211816.kBLIGFdf024664@turing-police.cc.vt.edu> <20061222115921.GT3073@harddisk-recovery.com> <1167568899.3318.39.camel@gimli.at.home> <3d57814d0612310503r282404afgd9b06ca57f44ab3c@mail.gmail.com> <200701020404.l0244n3b024582@turing-police.cc.vt.edu> <3d57814d0701012230v2e8b31eeqef7e542d73fc08d9@mail.gmail.com> <1167730833.12526.35.camel@tara.firmix.at> <3d57814d0701020326o2b3b5636mcf31147ad00e82c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d57814d0701020326o2b3b5636mcf31147ad00e82c6@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 09:26:14PM +1000, Trent Waddington wrote:
> The list of features which the driver supports is going to be
> sufficient evidence for 99% of patents that relate to computer
> graphics hardware.

Nope, not necessarily.  Recall that Patent Office has issued a patent
on the concept of using "XOR" in graphics operations (for dealing with
a cursor that's moving around).  There are plenty of patents involving
optimizations that can't be proven unless you have access to the
low-level source code or are willing to spend a huge amount of money
disassembling megabytes of binaries.  In fact, there are rumors
floating around that pthe reason why no one is willing to release
source code is that both sides are almost certainly violating each
other's trivial patents, and defending against a patent lawsuit can
take years, millions of dollars, and even if the patent is completely
and totally bogus, can put a company out of business.  Witness what
happened with Research in Motion and the patents allegedly covering
the Blackberry.  Even though the USPTO had already provisionally ruled
that there was prior art (the patent troll still had appeals to file),
the judge wasn't willing to wait for the USPTO process to finish, and
was prepared to issue a ruling that would put a 23 BILLION dollar
company out of business.  So RIMM ended up paying over half a billion
dollars of blackmail money to settle a patent lawsuit where the
patents may end up getting ruled completely bogus a year or two from
now anyway.

In any case, the rumor that was going around was that the reasn why
neither side is willing to release sources is because whoever did
would be committing potential corporate suicide first....

I can very easily believe it.  The US patent system and "justice"
system in the US is completely and totally insane, and companies often
feel they have to act accordingly.  Remember this is the country that
has issued multi-million dollar awards to people who spill hot coffee
in their lap and my favorite, to an idiot who lifted up a lawnmover to
trim their hedges, dropped the lawnmover on his foot and lost his foot
as a result.  The lawn mover company had to pay $$$ because they
hadn't thought to put in a idiot switch to stop the lawnmower blade
from spinning when it was lifted off the ground....

						- Ted

P.S.  The opinions expressed in this e-mail are completely my own; I'm
not important enough to decide the corporate position of my employer.  :-)

