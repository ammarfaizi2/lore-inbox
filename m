Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSH3WAr>; Fri, 30 Aug 2002 18:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSH3WAr>; Fri, 30 Aug 2002 18:00:47 -0400
Received: from adsl-66-125-254-44.dsl.sntc01.pacbell.net ([66.125.254.44]:10141
	"EHLO fiorano.interclypse.net") by vger.kernel.org with ESMTP
	id <S317590AbSH3WAq>; Fri, 30 Aug 2002 18:00:46 -0400
Subject: 2.4.18: APM & ASUS A7M266-D
From: Christopher Keller <cnkeller@interclypse.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-HtXaO4tvAi7Kwc0q8Bmg"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 30 Aug 2002 14:57:15 -0700
Message-Id: <1030744641.2588.64.camel@c_keller.beamreachnetworks.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HtXaO4tvAi7Kwc0q8Bmg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Kernel 2.4.18-X (RedHat version)
AMD MP 1900 CPU's

APM is enabled in the BIOS, yet the kernel presumably disables it with a
message along the lines of unsafe for dual CPU's (apologies, don't have
the box in front of me).

The result, as far as I can tell, is that the machine doesn't power off
when executing a shutdown/init 0. It simply displays the "Power Down"
message and sits there.=20

Booting with the "apm=3Dpower-off" flag doesn't seem to have any effect.=20

Could someone enlighten me as to what's up?

--=20
Homepage: http://interclypse.net
Registered Linux user #215241 (http://counter.li.org/)

--=-HtXaO4tvAi7Kwc0q8Bmg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9b+o7R6ATq7AtBW4RAtDfAKCFLib0RDq+JKk77nNoFJCoalS+8ACfZTpM
uet6jwAp36/Lao89gIIaidQ=
=ggoX
-----END PGP SIGNATURE-----

--=-HtXaO4tvAi7Kwc0q8Bmg--

