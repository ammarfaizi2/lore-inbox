Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbSLPR3j>; Mon, 16 Dec 2002 12:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbSLPR3i>; Mon, 16 Dec 2002 12:29:38 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:50159 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266978AbSLPR3W>; Mon, 16 Dec 2002 12:29:22 -0500
Subject: Re: Notification hooks
From: Arjan van de Ven <arjanv@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
In-Reply-To: <20021216171218.GV504@hopper.phunnypharm.org>
References: <20021216171218.GV504@hopper.phunnypharm.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zZzeOX/5yJaptawWEyHc"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 18:18:55 +0100
Message-Id: <1040059138.1438.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zZzeOX/5yJaptawWEyHc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-12-16 at 18:12, Ben Collins wrote:
> Linus, is there anyway I can request a hook so that anything that
> changes drivers/ieee1394/ in your repo sends me an email with the diff
> for just the files in that directory, and the changeset log? Is this
> something that bkbits can do?
>=20
> I'd bet lots of ppl would like similar hooks for their portions of the
> source.

well there is the bk commits list that has all individual changesets.
Add procmail and the patchutils program "grepdiff" to the recipe and I
think we have a winner.....

--=-zZzeOX/5yJaptawWEyHc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9/gr8xULwo51rQBIRAnggAJ97XpoIGsgbEVhcZqSE4BqInQ1Q9gCfUPEF
eoMQjjtbvezEcVwaQpQU30I=
=Izxh
-----END PGP SIGNATURE-----

--=-zZzeOX/5yJaptawWEyHc--
