Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTI2NX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTI2NX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:23:59 -0400
Received: from iucha.net ([209.98.146.184]:5697 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263344AbTI2NX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:23:56 -0400
Date: Mon, 29 Sep 2003 08:23:55 -0500
To: Jaroslav Kysela <perex@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030929132355.GA1206@iucha.net>
Mail-Followup-To: Jaroslav Kysela <perex@suse.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2003 at 06:27:35PM -0700, Linus Torvalds wrote:
>=20
[snip]
> arm, s390, ia64, x86-64, and ppc64 updates. USB, pcmcia and i2c stuff. An=
d=20
> a fair amount of janitorial.

I can no longer select my soundcard: In test5 it was configured by
CONFIG_SND_CS46XX! This option is no longer available in test6 (make
menuconfig does not offer me the opportunity).

It happened between test5-bk11 (option set/module build) and bk13
(option not available).

Please, give my sound option back!
florin

--=20

Don't question authority: they don't know either!

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eDJrNLPgdTuQ3+QRApi6AJ4kzcS+XiwCDU+5yNSZiRnYPJQZlACfXvZc
lB/DpoaJxe3bINE+vonZqh8=
=k1uC
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
