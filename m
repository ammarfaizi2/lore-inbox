Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUJZBuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUJZBuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUJZBuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:50:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42196 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261857AbUJZBTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:19:39 -0400
Date: Tue, 26 Oct 2004 02:06:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrea Arcangeli <andrea@novell.com>, Larry McVoy <lm@work.bitmover.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0410252350240.17266@scrub.home>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
 <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
 <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Oct 2004, Linus Torvalds wrote:

> In short, BK isn't the problem. You are.

I think you're making it yourself way too easy.

There is a certain ego problem, that makes a more rational discussion 
about the real influence of bk rather difficult. bk makes it in first 
place easier to apply and merge a lot of patches, but patches still have 
to be written, reviewed and maintained. The ability to handle big amounts
of patches includes also the possibility to merge a lot of crap. What 
keeps up the general quality? It would be a lot easier to give Larry some 
credit here, if he hadn't already taken it all.

There is a certain license problem, which very effectly keeps out a lot of 
those people, who might have other ideas for managing the kernel sources 
and improving the development process. The "protecting IP" talk is 
complete bullshit, one doesn't need direct access to figure out how it 
works. There are a few free SCM systems out there, that use very similiar 
mechanism, they of course still need to work out the details, but it's no 
magic and just takes times. Being able to import the kernel repository 
into them would be a great way to test them, but unfortunately all the 
free testing is reserved for bk, as usual the winner takes it all and the 
losers eat the dust, isn't that how open source works...?

Blaming Andrea for this mess is of course easy, but it doesn't solve 
anything and misses the point, the only thing Andrea is to blame for is 
that he is not very diplomatic, but that's unfortunately a trait seldom 
found under hackers. Ignoring the problems and silencing the critics 
doesn't solve anything and I would be more concerned if nobody would 
object anymore, when Larry is on one of his ego trips.

bye, Roman
