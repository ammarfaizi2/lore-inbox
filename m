Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbUCVWEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUCVWEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:04:38 -0500
Received: from mx1.actcom.net.il ([192.114.47.13]:23192 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263708AbUCVWEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:04:33 -0500
Date: Tue, 23 Mar 2004 00:03:27 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Jos Hulzink <jos@hulzink.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040322220326.GF13042@mulix.org>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org> <20040322215921.GU16746@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tez2gqrut5pn4jhH"
Content-Disposition: inline
In-Reply-To: <20040322215921.GU16746@fs.tum.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tez2gqrut5pn4jhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2004 at 10:59:21PM +0100, Adrian Bunk wrote:
> On Mon, Mar 22, 2004 at 10:22:21PM +0200, Muli Ben-Yehuda wrote:
> >...
> > I've seen
> > multiple bug reports of cards that work with OSS and don't work with
> > ALSA (and vice versa), so keeping both seems the proper thing to
> >...
>=20
> Wouldn't it be better to get the ALSA drivers working in such cases?

It would; but until they do, ditching OSS is a regression.=20

> It's really not a good idea to have two codebases for the same
> purpose.

It is if neither one is witholding effort from the other, and neither
one does a perfect job for all cases.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--tez2gqrut5pn4jhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX2KuKRs727/VN8sRAh/vAJ93x0ZB1Qp0VBQW4Nn5MulLqndTKACgpF8L
xR1CjiuLDQo4vgQbPXT/FZY=
=a9T5
-----END PGP SIGNATURE-----

--tez2gqrut5pn4jhH--
