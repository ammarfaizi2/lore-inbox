Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbTJSU7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJSU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:58:53 -0400
Received: from pool-162-84-134-188.ny5030.east.verizon.net ([162.84.134.188]:7931
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S262228AbTJSU6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:58:51 -0400
Subject: Re: Linux-2.6.0-test8, e1000 timeouts.
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Thomas Giese <Thomas.Giese@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <02a101c3967e$107b0810$fb457dc0@tgasterix>
References: <1066588403.1232.57.camel@blaze.homeip.net>
	 <01f601c39671$553cbaa0$fb457dc0@tgasterix>
	 <02a101c3967e$107b0810$fb457dc0@tgasterix>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A09Nrbu3r+JeEKuVY6bh"
Message-Id: <1066597186.12771.2.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (Slackware Linux)
Date: Sun, 19 Oct 2003 16:59:46 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-beta; AVE: 6.22.0.1; VDF: 6.22.0.9; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A09Nrbu3r+JeEKuVY6bh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-10-19 at 16:17, Thomas Giese wrote:

> did you test the transfer-rate? i got 3 KB/s in a local network :-(
>=20

It seems a bit low

--> scp linux-2.6.0-test8.tar.bz2 blazebox:/tmp

linux-2.6.0-test8.tar.bz2                                                  =
                                                            100%   32MB   2=
.9MB/s   00:10


--=-A09Nrbu3r+JeEKuVY6bh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/kvtBo0/Ad0tTwzgRAj+OAJ4z87T2cAr8mvs8rSHxk8b/t+MmzQCeLU8d
mJOgiSbw4DX2FeqkKGAYunU=
=L5lk
-----END PGP SIGNATURE-----

--=-A09Nrbu3r+JeEKuVY6bh--
