Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbUJ1BG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUJ1BG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUJ1BG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:06:59 -0400
Received: from THUNK.ORG ([69.25.196.29]:1218 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262473AbUJ1BGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:06:20 -0400
Date: Wed, 27 Oct 2004 21:05:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041028010534.GA5634@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410272214580.877@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 10:58:03PM +0200, Roman Zippel wrote:
> 
> Allow me to translate that what this means, so everyone clearly knows 
> what's going on here:
> The complete development history of the Linux kernel is now effectly 
> locked into the bk format, you can get a summary of it, but that's it.
> The data everyone put into a bk repository is now owned by BM and only if 
> you abide to the rules set by BM, do you have the permission to extract 
> some of the data again. You can completely forget the idea to one day 
> import "your" data into a different SCM system.

As compared to *before* we started using BK, when we kept no
development history whatsovever?  You think that's any better?

The summary of the information is pretty much everything that you
could get out of any other revision control system, so what's your
beef?

						- Ted
