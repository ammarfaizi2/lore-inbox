Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270639AbTGURwB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270673AbTGURvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:51:19 -0400
Received: from mailg.telia.com ([194.22.194.26]:14822 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S270671AbTGURuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:50:12 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
From: Christian Axelsson <smiler@lanil.mine.nu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030721173826.333bfa01.florian.huber@mnet-online.de>
References: <20030720125547.11466aa4.florian.huber@mnet-online.de>
	 <1058738091.5980.63.camel@localhost.localdomain>
	 <20030721173826.333bfa01.florian.huber@mnet-online.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WdECaoW8DFhv6W/9ii+s"
Message-Id: <1058810706.11170.2.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 20:05:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WdECaoW8DFhv6W/9ii+s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-21 at 17:38, Florian Huber wrote:
> On 20 Jul 2003 14:54:52 -0700
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>=20
> > Setting root=3D0303 (in your case) might helps things along.
>=20
> Thanks Jeremy, it's working :)

Yea this helps (I use root=3D0301 for /dev/hda1) but is the reason behind
this behavior located and fixed?

--=20
Christian Axelsson
  smiler@lanil.mine.nu

GPG ID:
  6C3C55D9 @ ldap://keyserver.pgp.com

--=-WdECaoW8DFhv6W/9ii+s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HCtQyqbmAWw8VdkRAgthAJ9A8q9DSPrtJBlgrj5NUTbD8vuIjQCgmD1b
j3QnkTOmptev2DKPuEz3fuA=
=w714
-----END PGP SIGNATURE-----

--=-WdECaoW8DFhv6W/9ii+s--

