Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUJaVHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUJaVHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUJaVHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:07:46 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:29301 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261655AbUJaVHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:07:30 -0500
Date: Sun, 31 Oct 2004 23:07:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Larry McVoy <lm@work.bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
       Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041031220716.GA21471@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com> <20041031204717.GF5578@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031204717.GF5578@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 09:47:17PM +0100, Pavel Machek wrote:
 
> ...but, if someone actually *tries* to import it into another system,
> your bandwidth bill will be so huge that you'll stop bkbits.net, no?
> How many terabytes would need to be transfered in order to do complete
> import of linux-kernel into another system?

Anyone that is allowed to use bitkeeper can do this.
Transfer data to another SCM is not illegal according
to the bk license.

	Sam (one of many happy bk users)
