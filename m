Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUFUHZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUFUHZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:21:44 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:64954 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S266144AbUFUHTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:19:46 -0400
Date: Mon, 21 Jun 2004 03:19:27 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: 2.6.7-bk way too fast
In-reply-to: <Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Message-id: <200406210319.38694.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <40D64DF7.5040601@pobox.com>
 <200406210239.28918.norberto+linux-kernel@bensa.ath.cx>
 <Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 21 June 2004 02:16, Linus Torvalds wrote:
> On Mon, 21 Jun 2004, Norberto Bensa wrote:
> > Attaaached,    ..cooonfiig  and   dmmesssg.  Note:   iit''s
> > waaaaaaaaaaaaaaay    too     fffasssst  on X.  Text moode    termiinall
> > it''ss  oook.
>
> Does it fix it to just remove that one line completely?
>
> Like this..
>
> 		Linus

I didn't try Andrew's patch, but your fixes it on my laptop.

Jeff.

- -- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1owHwFP0+seVj/4RAlqdAKCSNKjp2BP3q+hE7gkmdaOG45xeggCeKHWa
zKr9aTY4NXAPT24GSk2dtG8=
=NUoj
-----END PGP SIGNATURE-----
