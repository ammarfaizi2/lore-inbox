Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUAEXbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUAEXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:31:36 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:5560 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266004AbUAEXbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:31:31 -0500
Subject: Re: linux-2.4.24 released
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040105225104.GD4987@louise.pinerecords.com>
References: <200401051355.i05DtvgC020415@hera.kernel.org>
	 <1073321792.21338.2.camel@midux> <20040105171843.GA2407@alpha.home.local>
	 <1073324505.21338.11.camel@midux> <20040105190619.GD10569@fs.tum.de>
	 <1073336935.21983.4.camel@midux>
	 <20040105225104.GD4987@louise.pinerecords.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wdouF1WHDJeqyG9Sj+Me"
Message-Id: <1073345487.22399.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 01:31:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wdouF1WHDJeqyG9Sj+Me
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-06 at 00:51, Tomas Szepe wrote:
> On Jan-05 2004, Mon, 23:08 +0200
> Markus H=E4stbacka <midian@ihme.org> wrote:
>=20
> > cd /usr/src
> > cp linux-2.4.24/.config .
> > rm -rvf /linux-2.4.24
	    ^ ignore that /, it's a typo.
> Here you have deleted nothing (or a /linux-2.4.24 directory, if there
> was one), which would explain the problems.
Actually I deleted it, this was the steps I did to reproduce (The first
time I compiled it had grsecurity patches applied)
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-wdouF1WHDJeqyG9Sj+Me
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+fPP3+NhIWS1JHARAsHeAJ9nuYJPVmc7QnluuBXgNP84jrf97ACfeFH8
Ow+EjxVz8UlQM2Rg+U7ONRQ=
=C1yA
-----END PGP SIGNATURE-----

--=-wdouF1WHDJeqyG9Sj+Me--

