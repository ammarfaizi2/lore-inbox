Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUAFBME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbUAFBME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:12:04 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:56290 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S266054AbUAFBLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:11:53 -0500
Subject: Re: 2.6.1-rc1 affected?
From: Max Valdez <maxvalde@fis.unam.mx>
To: Bastiaan Spandaw <lkml@becobaf.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1073348624.1790.43.camel@louise3.void.org>
References: <1073320318.21198.2.camel@midux>
	 <Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
	 <1073326471.21338.21.camel@midux>
	 <Pine.LNX.4.58.0401051027430.2115@home.osdl.org>
	 <20040105193817.GA4366@lsc.hu>
	 <20040105224855.GC4987@louise.pinerecords.com>
	 <1073348624.1790.43.camel@louise3.void.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xVPvDCLiOU7usGi2mXee"
Message-Id: <1073351377.2690.1.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 19:09:37 -0600
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xVPvDCLiOU7usGi2mXee
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

At least it hangs a redhat 7.2 kernel=20

I will test it further tomorrow, but it looks like a good proof to me

Best regards
Max
On Mon, 2004-01-05 at 18:23, Bastiaan Spandaw wrote:
> On Mon, 2004-01-05 at 23:48, Tomas Szepe wrote:
> > On Jan-05 2004, Mon, 20:38 +0100
> > GCS <gcs@lsc.hu> wrote:
> >=20
> > > There _is_ an exploit: http://isec.pl/vulnerabilities/isec-0013-mrema=
p.txt
> > > "Since no special privileges are required to use the mremap(2) system
> > ...
> >=20
> > I will not believe the claim until I've seen the code.
>=20
> Not sure if this works or not.
> According to a slashdot comment this is proof of concept code.
>=20
> http://linuxfromscratch.org/~devine/mremap_poc.c
>=20
> Regards,
>=20
> Bastiaan
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Linux garaged 2.4.24 #2 SMP Mon Jan 5 17:41:16 CST 2004 i686 Pentium III (C=
oppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-xVPvDCLiOU7usGi2mXee
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+grRNNkpVEFxW78RAly8AJ4pxZqi5w3mYBg0xI0J2/y0ultosACgpAko
ZwqQXq8bH4Pp8uCH+QrAH+o=
=Knul
-----END PGP SIGNATURE-----

--=-xVPvDCLiOU7usGi2mXee--

