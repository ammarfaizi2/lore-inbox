Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUFQPrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUFQPrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUFQPqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:46:34 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17085 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266549AbUFQPqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:46:11 -0400
Date: Thu, 17 Jun 2004 17:46:08 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bruce Marshall <bmarsh@bmarsh.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use of Moxa serial card with SMP kernels
Message-ID: <20040617154608.GM20632@lug-owl.de>
Mail-Followup-To: Bruce Marshall <bmarsh@bmarsh.com>,
	linux-kernel@vger.kernel.org
References: <200406171112.39485.bmarsh@bmarsh.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9a90ueqXKpg1SWhp"
Content-Disposition: inline
In-Reply-To: <200406171112.39485.bmarsh@bmarsh.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9a90ueqXKpg1SWhp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-17 11:12:39 -0400, Bruce Marshall <bmarsh@bmarsh.com>
wrote in message <200406171112.39485.bmarsh@bmarsh.com>:
> Moxa serial card option not available when requesting an SMP kernel  (2.6=
=2E7)

> My question:   Is this a permanent problem which will never be fixed or a=
=20
> temporary situation?

It seems the Moxa driver is known-broken when running on a SMP system.
So this is permanent until somebody hacks it to work on multi-processor
machines...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--9a90ueqXKpg1SWhp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0bzAHb1edYOZ4bsRApiDAJ0Y/ZkMZqfHTK0XWh2lBtXam6DvpACfemZV
fUJyIcqpws0MSW2+djrXbuk=
=w/mg
-----END PGP SIGNATURE-----

--9a90ueqXKpg1SWhp--
