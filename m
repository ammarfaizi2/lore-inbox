Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJETt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJETt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJETrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:47:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51138 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265127AbUJETmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:42:38 -0400
Date: Tue, 5 Oct 2004 21:42:08 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
Message-ID: <20041005194208.GE11254@devserv.devel.redhat.com>
References: <1097004565.9975.25.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Tue, Oct 05, 2004 at 09:46:18PM +0200, Jesper Juhl wrote:
> On Tue, 5 Oct 2004, Arjan van de Ven wrote:
> 
> > If Richard overwrote his modules anyway he must have hacked the Makefile
> > himself to deliberately cause this, at which point... well saw wind
> > harvest storm ;)
> > 
> While I lack specific Fedora knowledge and thus can't provide exact 
> details for it I'd say it should still be pretty simple to recover. On 
> Slackware I'd simply boot a kernel from the install CD and tell it to 
> mount the installed system on my HD, then you'll have a running system and 
> can easily clean out the broken modules etc and install the original ones 
> from your CD and be right back where you started in 5 min. Surely 
> something similar is possible with Fedora, reinstalling from scratch (as 
> he said he did) seems like massive overkill to me.

yeah there is rescue mode for that reason on the first cd

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBYvkQxULwo51rQBIRApxdAJ9XeWCZdVamUZ8f8+kuC6nyswbAHQCdHSRH
awWqoVN9bNXTeLR4CR9/UPo=
=lnip
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
