Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbTG0ONe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270806AbTG0ONd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:13:33 -0400
Received: from diale221.ppp.lrz-muenchen.de ([129.187.28.221]:8340 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S270805AbTG0ONa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:13:30 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Daniel Egger <degger@fhm.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Yury Umanets <umka@namesys.com>, Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <3F23D38B.3020309@namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059228808.10692.7.camel@sonja>  <3F23D38B.3020309@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mMC31r85lhnL5BalAJLE"
Message-Id: <1059315015.10692.207.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 27 Jul 2003 16:10:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mMC31r85lhnL5BalAJLE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Son, 2003-07-27 um 15.28 schrieb Hans Reiser:

> it is suitable for any flash device that has wear leveling built into=20
> the hardware (e.g. all compact flash cards)

Are you sure CF cards have wear leveling? I'm pretty confident that they
have defect sector management but no wear leveling. There's a huge
difference between those two.

> or for which a wear leveling block device driver is used (I don't know
> if one exists for Linux).

This is normally done by the filesystem (e.g. JFFS2).

--=20
Servus,
       Daniel

--=-mMC31r85lhnL5BalAJLE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/I91Gchlzsq9KoIYRApAPAKC6nQ5wpfKGewY9esyRqhkzYUWFDQCg5VUe
U7FjQAyfKtdn5AS9q2T5uPU=
=yHsv
-----END PGP SIGNATURE-----

--=-mMC31r85lhnL5BalAJLE--

