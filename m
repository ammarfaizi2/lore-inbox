Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVC0Sza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVC0Sza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVC0Sza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:55:30 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:16796 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261368AbVC0SzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:55:08 -0500
Date: Sun, 27 Mar 2005 20:55:03 +0200
To: Andi Kleen <ak@muc.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
Message-ID: <20050327185500.GP943@vanheusden.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	<20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de>
	<424324F1.8040707@pobox.com> <20050327171934.GB18506@muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20050327171934.GB18506@muc.de>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Mar 26 23:38:20 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > pool.  The consensus was that the FIPS testing should be moved to users=
pace.
> Consensus from whom? And who says the FIPS testing is useful anyways?
> I think you just need to trust the random generator, it is like
> you need to trust any other piece of hardware in your machine. Or do you=
=20
> check regularly if you mov instruction still works? @)

For joe-user imho it's better to do a check from a cronjob once a day. But =
for
high demand security, maybe make it pluggable? Like that a user can plug-in=
 some
module which does the testing? Then you can have several kinds of tests
depending on your needs.


Folkert van Heusden

Auto te koop! Zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------=3D www.unixsoftware.nl =3D-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCRwGEMBkOjB8o2K4RAh7fAJ9ae8x9fYDQAjUgK6U6IFfADQwfwgCeJwY5
9oeoFwn5NLSWopK5OFpbLII=
=iphU
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
