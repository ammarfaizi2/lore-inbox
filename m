Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUJaUxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUJaUxr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUJaUxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:53:46 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:6884 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261365AbUJaUxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:53:45 -0500
Date: Sun, 31 Oct 2004 12:53:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041031205331.GD27728@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@suse.cz>, Roman Zippel <zippel@linux-m68k.org>,
	Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com> <20041031204717.GF5578@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031204717.GF5578@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 09:47:17PM +0100, Pavel Machek wrote:
> How many terabytes would need to be transfered in order to do complete
> import of linux-kernel into another system?
> 								Pavel

Not as much as it would take to do the same thing from a remote CVS server.
CVS is dramatically worse than diff and patch.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
