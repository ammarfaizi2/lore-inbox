Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWIBAwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIBAwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 20:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIBAwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 20:52:19 -0400
Received: from hentges.net ([81.169.178.128]:36059 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1750762AbWIBAwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 20:52:18 -0400
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
	easily reproducable
From: Matthias Hentges <oe@hentges.net>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060901184106.GI1959@cip.informatik.uni-erlangen.de>
References: <20060901184106.GI1959@cip.informatik.uni-erlangen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S78Q3cW55UhNqHaLq7VT"
Date: Sat, 02 Sep 2006 02:53:11 +0200
Message-Id: <1157158391.20509.4.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S78Q3cW55UhNqHaLq7VT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 01.09.2006, 20:41 +0200 schrieb Thomas Glanzmann:
> Hello,
> my sky2 network card in my intel mac mini just stopped working again on
> me. After a reboot it worked again. This time there is no dmesg output
> related to the problem. :-( Am I the only one who sees that?

Nope, same here on an Asus P5W DH Deluxe mainboard. The sky2 NIC just
silently dies after some time. Rmmod + modprobe sky2 used to re-enable
the NIC IIRC. Since this bug makes the driver practically unusable I
have since switched to a PCI NIC (which is a shame considering the 2
gigabit sky2 NICs on the mainboard...).


--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-S78Q3cW55UhNqHaLq7VT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE+NX2Aq2P5eLUP5IRAoElAJ9h9ug8Pq+FT0cJStUdvJmdAezkGQCgzZ3g
qfac1xcACtVSn+nDVZ/x8JA=
=CcfR
-----END PGP SIGNATURE-----

--=-S78Q3cW55UhNqHaLq7VT--


-- 
VGER BF report: U 0.5
