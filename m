Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTIABAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTIABAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:00:09 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:46353 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S262887AbTIABAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:00:05 -0400
Date: Sun, 31 Aug 2003 21:00:02 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901010002.GA19430@linux-sh.org>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030901002412.GA16537@linux-sh.org> <20030901003750.GB31531@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20030901003750.GB31531@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2003 at 01:37:50AM +0100, Jamie Lokier wrote:
> > sh (VIPT cache):
> >=20
> > Test separation: 4096 bytes: FAIL - cache not coherent
> > Test separation: 8192 bytes: FAIL - cache not coherent
> > Test separation: 16384 bytes: pass
>=20
> A VIVT cache can do that, but I think a VIPT cache should always be coher=
ent.
> Do I misunderstand?
>=20
There's nothing stating that VIPT =3D=3D automatic coherency, as is obvious=
ly the
case for sh, where we are completely VIPT, but are also non coherent.


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/UpoS1K+teJFxZ9wRAtIoAJ9ifnPfuCcp7zlxpRSiOKhup58bRACePPIT
JQkAV7MzOeDa5ukGLkFWqXY=
=UzNj
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
