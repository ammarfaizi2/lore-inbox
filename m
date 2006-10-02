Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWJBPG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWJBPG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWJBPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:06:28 -0400
Received: from natgw.netstream.ch ([62.65.128.28]:59096 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932508AbWJBPG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:06:27 -0400
Date: Mon, 2 Oct 2006 17:06:22 +0200
From: Nico Schottelius <nico-kernel20060920@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nico Schottelius <nico-kernel20060920@schottelius.org>
Subject: Block information: Changing from GB to GiB
Message-ID: <20061002150622.GC17627@schottelius.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       nico-kernel20060920@schottelius.org
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	nico-kernel20060920@schottelius.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Would you accept patches, which
   a) add printing MiB, GiB, ... ADDITIONALy to MB, GB, ..
   b) replace GB with GiB
?

If so, I would check the kernel source for occurences of those
units and replace the calculation.

Imho, it would be nicer to print GiB only, because it's the more
accurate unit (today).

You can have a look at GiB and co. at wikipedia, if you are not familar
with it: http://en.wikipedia.org/wiki/Gigabyte

Sincerly

Nico

P.S.: Please CC me on reply.


--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFISruuL75KpiFGIwRAte8AKCnEJdrvNCM/RuYA+Hn1xUz+XIXvgCgknYV
P1c/rrBrw8Z1Dsprp2i0HME=
=LdnK
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
