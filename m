Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTFUSIA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 14:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTFUSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 14:08:00 -0400
Received: from brmea-mail-2.Sun.COM ([192.18.98.43]:52885 "EHLO
	brmea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265252AbTFUSH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 14:07:59 -0400
Date: Sat, 21 Jun 2003 11:22:00 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: Re: Announce: kdb v4.3 is available for kernels 2.4.20, 2.4.21
In-reply-to: <4310.1056174819@firewall.ocs.com.au>
To: Keith Owens <kaos@sgi.com>
Cc: kdb@oss.sgi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1056219720.21882.87.camel@biznatch>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2)
Content-type: multipart/signed; boundary="=-HAPowZ13ISHG3EYIaHu6";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <4310.1056174819@firewall.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HAPowZ13ISHG3EYIaHu6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-06-20 at 22:53, Keith Owens wrote:
> On Fri, 20 Jun 2003 17:22:41 -0700,=20
> Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu> wrote:
> >On Fri, 2003-06-20 at 00:07, Keith Owens wrote:
> >
> >>   Other 2.4.21 arch patches will appear later.
> >
> >Here is a pointer to the sparc64 arch patch:
> >
> >http://www.dslextreme.com/users/tomduffy/kdb-v4.3-2.4.21-sparc64-1.bz2
> >
> >It includes very minor changes to make it work on 2.4.21.
>=20
> Thanks Tom.  Uploaded to ftp://oss.sgi.com/projects/kdb/download/v4.3

2003-06-21 Tom Duffy <Thomas.Duffy.99@alumni.brown.edu>

        * got rid of kdb_eframe_t per Keith's request
        * fixed double printing on kdb command line
        * kdb v4.3-2.4.21-sparc64-2

can be found on:

http://www.dslextreme.com/users/tomduffy/kdb-v4.3-2.4.21-sparc64-2.bz2

-tduffy

--=20
Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>

--=-HAPowZ13ISHG3EYIaHu6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+9KJIdY502zjzwbwRAhkSAJ9asRlPNZ5eoBDoKoZwO4228G4LugCfaTy4
gMVCDpu5jLDQ/r1tM3dO1Tw=
=7YEo
-----END PGP SIGNATURE-----

--=-HAPowZ13ISHG3EYIaHu6--

