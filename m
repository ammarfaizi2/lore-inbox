Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUAKLwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265850AbUAKLwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:52:40 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:28545 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265847AbUAKLuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:50:39 -0500
Subject: Re: [PATCH 2.6.0] Cirrus PD6729 PCI-to-PCMCIA Bridge support for
	2.6.x kernel
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Komuro <komujun@nifty.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1073819401.2329.7.camel@localhost.localdomain>
References: <1073819401.2329.7.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WC+M2rG3mHD2DJx8835m"
Organization: Red Hat, Inc.
Message-Id: <1073821829.4431.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 12:50:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WC+M2rG3mHD2DJx8835m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 12:16, Komuro wrote:
> Dear all
>=20
> I made a Cirrus PD6729 PCI-to-PCMCIA Bridge for 2.6.x kernel.
> Please see the following patch. ( sorry for big patch)

looks good on first sight; worth adding to -mm for sure (and then into
mainline)

--=-WC+M2rG3mHD2DJx8835m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAATiFxULwo51rQBIRAuVJAJ94ZDqOcyE87t9gg965dwBcy+JI9gCgiKwx
jJ8PYiZu02bxFvCgpJ1RTQI=
=/1kU
-----END PGP SIGNATURE-----

--=-WC+M2rG3mHD2DJx8835m--
