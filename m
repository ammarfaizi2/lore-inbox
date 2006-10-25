Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWJYOZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWJYOZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWJYOZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:25:13 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:35259 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1751629AbWJYOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:25:11 -0400
Date: Wed, 25 Oct 2006 16:25:04 +0200
From: martin f krafft <madduck@debian.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: 394200-forwarded@bugs.debian.org
Subject: mysterious freeze on X40 with 2.6.16/17/18
Message-ID: <20061025142504.GA26948@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	394200-forwarded@bugs.debian.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-Debbugs-No-Ack: please spare me
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi kernel team,

I have been fighting with kernel freezes on my X40 for the 2.6.16-18
kernels (I am using Debian and their kernels). Apparently 2.6.14
works fine, but I can't ever be sure...

You can see my bug log at http://bugs.debian.org/394200

I would appreciate if you could look at it; I'd be happy to try
things out if it helps to narrow down the problem.

Cheers,

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFP3PAIgvIgzMMSnURAlpjAJ9m+YneVfkaQ9AZhyctQR9hx72JsQCgwc/F
Wlun/IYOLKw6zeDOb1/3M6Q=
=VIbL
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
