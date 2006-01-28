Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWA1GZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWA1GZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 01:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWA1GZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 01:25:19 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63940 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751584AbWA1GZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 01:25:19 -0500
Date: Sat, 28 Jan 2006 06:25:04 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-ID: <20060128062504.GW27946@ftp.linux.org.uk>
References: <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <1138387136.26811.8.camel@localhost> <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <Pine.LNX.4.64.0601280001000.2909@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601280001000.2909@evo.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 12:22:58AM -0500, Linus Torvalds wrote:
> PS. Just out of historical interest, the only other copyright license ever 
> distributed with the kernel was this one:
> 
>  "This kernel is (C) 1991 Linus Torvalds, but all or part of it may be
>   redistributed provided you do the following:
> 
> 	- Full source must be available (and free), if not with the
> 	  distribution then at least on asking for it.
> 
> 	- Copyright notices must be intact. (In fact, if you distribute
> 	  only parts of it you may have to add copyrights, as there aren't
> 	  (C)'s in all files.) Small partial excerpts may be copied
> 	  without bothering with copyrights.
> 
> 	- You may not distibute this for a fee, not even "handling"
> 	  costs.
> 
>   Mail me at "torvalds@kruuna.helsinki.fi" if you have any questions."
> 
> and that one was only valid between kernel versions 0.01 and 0.12 or 
> something like that.

Interesting...  What does that do to e.g. DVD with full (OK, modulo missing
early versions) kernel history all way back to 0.01?

Even funnier question is what does that do to full CVS including the
early versions.  Can that be distributed at all and what license would
fit it?  Arguing that it's mere aggregation is possible, but it's a
bit of a stretch...
