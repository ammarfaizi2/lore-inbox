Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVCHBzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVCHBzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVCHBv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:51:58 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:35844 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261793AbVCGVN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:13:28 -0500
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
	2.6
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
       cryptoapi@lists.logix.cz, James Morris <jmorris@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <11102278521318@2ka.mipt.ru>
References: <11102278521318@2ka.mipt.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Qq4R3lS5DWOLF0D2BvFN"
Date: Mon, 07 Mar 2005 22:13:18 +0100
Message-Id: <1110229998.13172.48.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qq4R3lS5DWOLF0D2BvFN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-07 at 23:37 +0300, Evgeniy Polyakov wrote:

> I'm pleased to announce asynchronous crypto layer for Linux kernel 2.6.

Thanks Evgeniy for your work! Even though, it's great what's inside, I'm
afraid it will be judged by the form of its presentation. A patch should
be something integral, testable on its own. I think it's not necessary
to package it that fine grained, as it becomes very hard to apply with a
regular mail reader (Saving/Exporting 50 mails is really a bit of a
work).

So, the form is a bit suboptimal. Don't hesitate to put all "acrypto*"
and "arch*" patches in one-large acrypto patch set, and an other for
"bd*". I'd be glad to say something different, but I think acrypto has
not been considered by the maintainers to be merged soon, so patch
splitting doesn't make sense anyway at the moment.

Best Regards,
--=20
Fruhwirth Clemens - http://clemens.endorphin.org=20
for robots: sp4mtrap@endorphin.org

--=-Qq4R3lS5DWOLF0D2BvFN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCLMPubjN8iSMYtrsRAoHWAJsHsaSQCt4c9HToH0IZjZaFS2tjHQCglWPG
pnALseOJyRfgm9k6pd2vrbc=
=6ASW
-----END PGP SIGNATURE-----

--=-Qq4R3lS5DWOLF0D2BvFN--
