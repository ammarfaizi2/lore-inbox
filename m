Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVBQUhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVBQUhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBQUfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:35:15 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:3970 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262346AbVBQUdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:33:11 -0500
Date: Thu, 17 Feb 2005 21:33:08 +0100
From: David Weinehall <tao@debian.org>
To: lm@bitmover.com, linux-os <linux-os@analogic.com>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050217203308.GG19998@khan.acc.umu.se>
Mail-Followup-To: lm@bitmover.com, linux-os <linux-os@analogic.com>,
	Jeff Sipek <jeffpc@optonline.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <Pine.LNX.4.61.0502141113200.4019@chaos.analogic.com> <20050214171219.GA8846@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214171219.GA8846@bitmover.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 09:12:19AM -0800, Larry McVoy wrote:
> > >So how would you suggest that we resolve it?  The protection we need is
> > >that people don't get to
> > >
> > >   - use BK
> > >   - stop using BK so they can go work on another system
> > >   - start using BK again
> > >   - stop using BK so they can go work on another system
> > 
> > What??? Why not? BK is a PROGRAM. You can't tell somebody
> > that once they use some program in one job, they can't
> > use it again. What kind of "protection" are you claiming?
> 
> It is a program that comes with a license.  Licenses have terms which
> survive the termination of the license, that's industry standard, they
> all have such terms.
> 
> In this case the situation is unusual because we have a program that is
> ahead, in some ways, of all the other programs out there that do the
> same thing.  We'd like to protect that lead.  We put that lead at risk
> by giving you BK for free, that's more or less suicide because the open
> source world has a long track record of copying that which they find
> useful.  We don't want you to copy it.  If you can't agree to not copy
> it then you don't get to use it in the first place.

Does these license terms (the ones concerning developing competing
software while, or within a year of, using BK) also apply to the
commercial license?

BTW: Wishlist request.  Would you consider adding -p (--show-c-function)
to the set of flags used for the diffs created by BitKeeper?


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
