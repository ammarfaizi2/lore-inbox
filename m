Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVDRTv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVDRTv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDRTv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:51:26 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:13532 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262188AbVDRTu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:50:58 -0400
Subject: Re: [PATCH 0/7] procfs privacy
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Rik van Riel <riel@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0504181526280.11251@chimarrao.boston.redhat.com>
References: <1113849977.17341.68.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504181526280.11251@chimarrao.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DEhsqYCJMDHmxpG6XKSz"
Date: Mon, 18 Apr 2005 21:46:01 +0200
Message-Id: <1113853561.17341.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DEhsqYCJMDHmxpG6XKSz
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 18-04-2005 a las 15:27 -0400, Rik van Riel escribi=F3:
> The same "this forces people to run system monitoring tasks
> as root, potentially opening themselves up to security holes"
> comment applies to this patch.

That's because the patch is split up, those bits are on the proc_misc
one.

I agree, btw. ;)

Adding a "trusted user group"-like configuration option could be useful,
as it's done within grsecurity, among that the whole thing might be good
to depend on a config. option, but that implies using weird ifdef's and
the other folks.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-DEhsqYCJMDHmxpG6XKSz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZA55DcEopW8rLewRAhzwAKDNa0onzZ2LQA3liZ/rY6Axoc00mgCaAohj
tFZzlZQuneqdToRBlHrwJ1w=
=/ZXR
-----END PGP SIGNATURE-----

--=-DEhsqYCJMDHmxpG6XKSz--

