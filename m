Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAXIn5>; Wed, 24 Jan 2001 03:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130172AbRAXInh>; Wed, 24 Jan 2001 03:43:37 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:51720 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129867AbRAXIna>; Wed, 24 Jan 2001 03:43:30 -0500
Date: Wed, 24 Jan 2001 08:42:51 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <paulus@linuxcare.com.au>, <l_indien@magic.fr>, <jma@netgem.com>,
        <callahan@maths.ox.ac.uk>, <jfree@sovereign.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bug in ppp_async.c
In-Reply-To: <200101240701.f0O71OE110437@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.30.0101240840210.1767-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Albert D. Cahalan wrote:

> Paul Mackerras writes:
> > I'll bet you're using an old pppd.  You need version 2.4.0 of pppd,
> > available from ftp://linuxcare.com.au/pub/ppp/, as documented in the
> > Documentation/Changes file.
> 
> Even Red Hat 7 only has the 2.3.11 version.

That's probably because Red Hat 7 didn't ship with a 2.4.0 kernel.

> The 2.4.xx series is supposed to be stable. If there is any way
> you could add a compatibility hack, please do so.

The 2.4.0 Documentation/Changes file already said that pppd should be at
least v2.4.0. That hasn't changed, AFAICT.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
