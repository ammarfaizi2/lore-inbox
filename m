Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTA2BvP>; Tue, 28 Jan 2003 20:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTA2BvP>; Tue, 28 Jan 2003 20:51:15 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:9992 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id <S262208AbTA2BvO>; Tue, 28 Jan 2003 20:51:14 -0500
Date: Wed, 29 Jan 2003 12:56:42 +1100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Bill Davidsen <davidsen@tmr.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] initrd/mkinitrd still not working
Message-ID: <20030129015642.GA10566@gondor.apana.org.au>
References: <Pine.LNX.3.96.1030128120708.32466C-100000@gatekeeper.tmr.com> <20030129005134.6E7E82C41B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129005134.6E7E82C41B@lists.samba.org>
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 11:48:17AM +1100, Rusty Russell wrote:
> In message <Pine.LNX.3.96.1030128120708.32466C-100000@gatekeeper.tmr.com> you w
> rite:
> > beating around the bush: how about adding mkinitrd to the other module
> > stuff before 0.9.9 is really released, using the same .old technique used
> > for insmod et al? It would allow people doing testing of both 2.4 and 2.5
> > kernels to stop fighting build issues.
> 
> Herbert, I'd be happy to discuss any mkinitrd changes, or put a patch
> into module-init-tools (or the FAQ?).

Actually, Debian's mkinitrd already works module-init-tools, I've got
it running here with 2.5.59.  However, the original poster is probably
referring to the RedHat program with the same name but is completely
different.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
