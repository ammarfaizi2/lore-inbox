Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTLOWOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTLOWOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:14:14 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:19903 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264254AbTLOWON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:14:13 -0500
Date: Mon, 15 Dec 2003 14:14:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215221410.GC8130@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]> <20031215151126.3fe6e97a.vsu@altlinux.ru> <20031215132720.GX7308@phunnypharm.org> <20031215192402.528ce066.vsu@altlinux.ru> <20031215183138.GJ6730@dualathlon.random> <20031215185839.GA8130@work.bitmover.com> <20031215194057.GL6730@dualathlon.random> <20031215214452.GB8130@work.bitmover.com> <20031215220257.GM6730@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215220257.GM6730@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 11:02:57PM +0100, Andrea Arcangeli wrote:
> On Mon, Dec 15, 2003 at 01:44:52PM -0800, Larry McVoy wrote:
> > all.  It's our tool and the use of our tool to export information how the
> 
> is the web your tool too?

The web isn't a tool and it certainly isn't our tool.  The web server on
bkbits.net is our tool, that's BitKeeper serving up the web pages directly.

> in your previous email you said the information is available via bkbits
> web.  But in an older email you said if we would use the web to fetch
> information you would shut it down (for whatever reason, not relevant
> for this email). Please clarify this single point: is the "web" a tool
> we can use to fetch information? 

I said I'd shut it down if you melted down the T1 line.  We have dual
T1 lines and rate limited them on both ends so that problem is gone.

You can grab all the patches you want from bkbits.net until you start
using those patches to populate another SCM system because at that point
you are using BK in violation of the BK license.

Tupshin wants both the patches and all the details of how the patches have
been put together.  I know why he wants it, it's a ton of useful test data
if what you are doing is building a clone of BitKeeper, and that's exactly
why he can't have all the information he wants.  It's disingenuous of him
to pretend it is a freedom of speech issue, but I think it's obvious to
everyone what is going on here.  If he was actually a kernel developer
using BK he'd be asking us to reduce the amount of information contained
in BitKeeper so that it ran faster which is what Linus wants us to do.
This is all about someone trying to circumvent our license, not about 
some valuable information that BK is losing or hiding.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
