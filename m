Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUAKNVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUAKNVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:21:14 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:1417 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261595AbUAKNVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:21:11 -0500
Subject: Re: [announcement, patch] real-time interrupts for the Linux kernel
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Bernhard Kuhn <bkuhn@metrowerks.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <3FFE078D.20400@metrowerks.com>
References: <3FFE078D.20400@metrowerks.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LyBRzxwX+caxv8FZd/gj"
Message-Id: <1073827448.9096.119.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 15:24:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LyBRzxwX+caxv8FZd/gj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-09 at 03:44, Bernhard Kuhn wrote:
> Hi everybody!
>=20
> I hope that i can steal enough of your precious time to get
> your attention for a new patch that adds hard real time support
> to the linux kernel (worst case interrupt response time below
> 5 microseconds):
>=20
> The proposed "real time interrupt patch" enables the linux
> kernel for hard-real-time applications such as data aquisition
> and control loops by adding priorities to interrupts and spinlocks.
>=20
> The following document will describe the patch in detail and how
> to install it:
>=20
> http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/README
>=20
>=20
> The patch and a demo application can be downloaded from:
>=20
> http://home.t-online.de/home/Bernhard_Kuhn/rtirq/20040108/rtirq-20040108.=
tgz
>=20
>=20
> Comments are highly appreciated!
>=20
>=20

Do you have actual benchmarks, and what 2.4 rather than 2.6 ?


Thanks,

--=20
Martin Schlemmer

--=-LyBRzxwX+caxv8FZd/gj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAU54qburzKaJYLYRAiBWAJ0VFrbCS9ruV2gtKNUaMAk/2fJz9gCglqeb
tkd29ekpw2RiZoJC2KkZHQk=
=GRgF
-----END PGP SIGNATURE-----

--=-LyBRzxwX+caxv8FZd/gj--

