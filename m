Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTIUOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTIUOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 10:22:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31899
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261877AbTIUOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 10:22:24 -0400
Date: Sun, 21 Sep 2003 16:22:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030921142252.GB16399@velociraptor.random>
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030919203538.D1919@flint.arm.linux.org.uk> <20030919200117.GE1312@velociraptor.random> <20030919205220.GA19830@work.bitmover.com> <20030920033153.GA1452@velociraptor.random> <20030920043026.GA10836@work.bitmover.com> <20030920142314.GA1338@velociraptor.random> <20030920151332.GA18387@work.bitmover.com> <m1smmqjug2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1smmqjug2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 04:40:29AM -0600, Eric W. Biederman wrote:
> Careful with your accusations Larry, some of us can answer those questions,
> in ways that won't support your argument.

It didn't worth an answer IMHO, he's ignoring lots of efforts going on,
AFIK you're in the bios area like many others, especially for x86-64 it
sounds very promising. notably these days my PDA strictly runs open
source since I strictly need it for security reasons, for istance I
nuked Opera immediatly and replaced it with konqueror and the whole
openzaurus suite, I will do the same soon with the cellphone, and
everything he listed is all but critical, and we pay that as well to
have some sort of warranty most of the time, at least for the first few
years, nothing like the bkbits.net that can be shutdown anyday, Larry
made sure he can turn everything "free" of anytime AFIK. And we have
many providers for cellphones microwaves cars etc.. not just one. If
something breaks and can't be repaired I throw it away and buy another
one.

But it would be unacceptable to throw away the whole 2.5 changesets
instead. And without this bkcvs export in the open, they could be lost
anyday of the week. And I can't even try to extract those with b*tkeeper,
since it's illegal to do so from my part. yeah, if there wasn't bkcvs,
somebody had to sacrifice his freedom for us to extract this closed info
encoded in proprietary form (like a .doc). since many already sacrificed
their freedom of development in this area, maybe it wouldn't be too bad,
they're already screwed so it can't go worse for them, but bkcvs to me
sounds much safer than an hope that somebody oneday will do the
conversion after sacrificing its freedom and after sorting out the
linearization of the tree.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
