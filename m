Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTEAM7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTEAM7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 08:59:44 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:43517 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261247AbTEAM7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 08:59:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Larry McVoy <lm@bitmover.com>, paulus@samba.org
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
Date: Thu, 1 May 2003 08:11:44 -0500
X-Mailer: KMail [version 1.2]
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <170EBA504C3AD511A3FE00508BB89A9202032941@exnanycmbx4.ipc.com> <16048.20899.694659.419853@nanango.paulus.ozlabs.org> <20030501010317.GB8676@work.bitmover.com>
In-Reply-To: <20030501010317.GB8676@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <03050108114401.26224@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 20:03, Larry McVoy wrote:
[snip]
> Don't get me wrong, I think Microsoft as an OS company is the worldest
> biggest joke.  Anyone who thinks that socket "handles" are different
> than file "handles" just doesn't get the abstraction at all.  It's
> pathetic, amazingly so.  But they got the application support layer
> pretty right or at least very useful and workable.

And it is the biggest source of security problems that has ever existed.

One of the reasons the UNIX implementation (corba and others) haven't worked
real well is:

1. complexity of usage
2. nonportability (a version on SUN will tend to fail to communicate with one 
on HP)
3. security verification.

M$ hasn't had to deal with #2 (since all the world is intel ((their view)),
and obviously doesn't deal with #3. #1 is handled by not allowing people to
use it (the cause of so many "undocumented interfaces"), and instead force
the use of interfacing languages that ignore #2 and #3.
