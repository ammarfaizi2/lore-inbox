Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbULPQkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbULPQkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbULPQkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:40:13 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3992 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261573AbULPQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:39:42 -0500
Date: Thu, 16 Dec 2004 09:39:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Montavista Realtime compilation failures
Message-ID: <20041216163940.GC25810@smtp.west.cox.net>
References: <41BFD327.3000408@comcast.net> <20041215094954.GA19147@infradead.org> <41C09244.2030403@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C09244.2030403@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 02:36:36PM -0500, John Richard Moser wrote:
> Christoph Hellwig wrote:
> | On Wed, Dec 15, 2004 at 01:01:11AM -0500, John Richard Moser wrote:
> |
> |>-----BEGIN PGP SIGNED MESSAGE-----
> |>Hash: SHA1
> |>
> |>The MontaVista patches[1] I applied to 2.6.9 are not compiling on
> |>x86_64.  I'm also using a PaX pre-patch, which I don't believe is
> |>interfering; there were collisions with PaX in mm/, but none of those
> |>show here (they were all in .c files, not headers, so they cannot have
> |>an impact here).
> |
> |
> | I think you're much better off complaining to mvista.
> |
>
> Ahh, alright, sorry.  I remember they announced this stuff to the list,
> so I thought it had reached the general interest of the LKML.

Yes, this really is the right place for it.  Except that the work in
question has been superceeded by what's in Ingo's patches now (and I
thought the original announcement of these particular patches said it
was i386 only, but I could be mistaken).

-- 
Tom Rini
http://gate.crashing.org/~trini/
