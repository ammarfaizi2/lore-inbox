Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTIAHH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIAHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:07:25 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:48512
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S262723AbTIAHG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:06:58 -0400
Date: Mon, 1 Sep 2003 09:07:32 +0200
To: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cryptoloop on 2.4.22/ppc doesn't work
Message-ID: <20030901070732.GA7557@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063264053.c002@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2001 at 01:35:46PM +0100, Christian Jaeger wrote:
>=20
> I cannot seem to get crypto loopback to run.

=2E.

> This is Debian woody, /sbin/losetup from mount package 2.11m-1
>=20
> Why doesn't it work?

You need to update util-linux. 2.12pre is recommend in addition to jari's
crypto patches:=20

http://www.kerneli.org/pipermail/cryptoapi-devel/2003-June/000578.html

Regards, Clemens

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/UvA0W7sr9DEJLk4RAvC9AJ91T+xNXWR4QXsRhIbLAscvx5cq9QCeOXsm
W4oek4S5qJPtYj0dc/IUGzo=
=Zpcf
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
