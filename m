Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271376AbTHLS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271359AbTHLS4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:56:24 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:12498
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S271341AbTHLS4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:56:09 -0400
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <2425882704.1060622541@aslan.btc.adaptec.com>
References: <1060543928.887.19.camel@blaze.homeip.net>
	 <2425882704.1060622541@aslan.btc.adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TBefMCLAjaqHbg9WZXz5"
Message-Id: <1060714576.849.3.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Tue, 12 Aug 2003 14:56:16 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.10; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TBefMCLAjaqHbg9WZXz5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-11 at 13:22, Justin T. Gibbs wrote:

>=20
> I don't think that any of the changes between 6.2.35 and 6.2.36 will
> make a difference for you, but you could try upgrading.  The source
> files are here:
>=20
> http://people.FreeBSD.org/~gibbs/linux/SRC/
>=20
> The console output you've provided makes me think that interrupts are
> not working correctly in your system.
>=20
> --
> Justin
>=20
>=20

Justin,

I have a nice oops from the
http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.5-20030603-tar.g=
z driver on 2.6.0-test3.

I took few snaps which show the scsi controller scan process and the
oops from kernel, they are at:
http://www.blazebox.homeip.net:81/diffie/images/linux-2.6.0-test2/2.6.36/

Paul

--=-TBefMCLAjaqHbg9WZXz5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/OThPIymMQsXoRDARAmtHAJ0a6Gh56EYg1/7xyzoSKvXJscGAGACeIXEX
ZgrrGU73qaeiTWKy/JMJ0pw=
=ymEt
-----END PGP SIGNATURE-----

--=-TBefMCLAjaqHbg9WZXz5--

