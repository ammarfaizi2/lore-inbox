Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUEXQyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUEXQyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUEXQyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:54:37 -0400
Received: from wblv-36-95.telkomadsl.co.za ([165.165.36.95]:60311 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263325AbUEXQyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:54:35 -0400
Subject: Re: [PATCH] scaled-back caps, take 4
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <87pt8upmjf.fsf@goat.bogus.local>
References: <fa.i8g63r1.9jata3@ifi.uio.no> <fa.hjocttu.1cgcc3q@ifi.uio.no>
	 <40B0F65F.3020706@myrealbox.com>  <87pt8upmjf.fsf@goat.bogus.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w9RGmARV8OqcCytYm4OX"
Message-Id: <1085417722.9516.4.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 18:55:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w9RGmARV8OqcCytYm4OX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > And no, I don't think this patch is necessary, or that it should be
> > applied or used by itself.  I think it makes a good starting point to
> > fix caps
> > (which a lot of people seem to think are broken).
>=20
> Well, I know, that I don't have a strong following. :-)
>=20

It might just be that not many are familiar with the code, or really
care.  If your patch really have 100% the same behaviour as the
original, and maybe some comments might be added as in how things
work, it can really help future debugging/additions/whatever, as
its so much easier (IMHO, not really caring much myself, but somebody
looking is better than nobody).  You might check with Andrew if he
wants to kick it around a bit in -mm ... ?


Cheers,

--=20
Martin Schlemmer

--=-w9RGmARV8OqcCytYm4OX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsij6qburzKaJYLYRAq1fAJ91vB7KMOlmfzxie7qhNpGh1WuGYACfciFz
yrsaIzyOVl92lu2gYNPkbpg=
=3cZd
-----END PGP SIGNATURE-----

--=-w9RGmARV8OqcCytYm4OX--

