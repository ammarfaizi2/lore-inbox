Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271032AbRIOFLa>; Sat, 15 Sep 2001 01:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272012AbRIOFLU>; Sat, 15 Sep 2001 01:11:20 -0400
Received: from mail.direcpc.com ([198.77.116.30]:34960 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S271032AbRIOFLM>; Sat, 15 Sep 2001 01:11:12 -0400
Subject: Random Sig'11 in XF864 with kernel > 2.2.x
From: Jeffrey Ingber <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-8FrO+4xcnW7ZisDzcwIY"
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.20.39 (Preview Release)
Date: 15 Sep 2001 01:09:45 -0400
Message-Id: <1000530589.2267.11.camel@DESK-2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8FrO+4xcnW7ZisDzcwIY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



Hello kernel developers:

I'm experiencing random Signal 11's on kernels in the 2.4 series with
XFree86 4 and SMP configurations.  Here a some threads to the XFree86
mailing lists which suggest that the Signal 11's are kernel related.=20
Downgrading to a 2.2 series kernel solves these problems:

http://www.xfree86.org/pipermail/xpert/2001-September/011053.html
http://www.xfree86.org/pipermail/xpert/2001-September/011229.html


Here's a snippet from my posting to the list: =20

----
> Dell PowerEdge 6300 (Quad Xeon 500) with ATI Rage 128
> IBM Netfinity 5600 (Dual PIII 667) with Matrox MMS Quad Monitor
> Tyan Tunderbolt S1873UANG-R (Dual PIII 600) with Matrox Marvel G400

   I'll bet it goes away if you don't use a 2.4 SMP kernel.
That is, use a 2.4 UP kernel or a 2.2 UP/SMP kernel.
---

And this turned out to be the case.  Is there anything that I could do
help fix this?  Is there anyone else on this list that has had similar
problems and has overcome this?


Thanks for listening.
Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)



--=-8FrO+4xcnW7ZisDzcwIY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7ouKZaMTzuMuv5OERArUOAKCdQ/QpP19q+KEi27DGQdF67h4lswCZAepR
Fy5OGSmkisNtXkwAmJcXUBI=
=CUxY
-----END PGP SIGNATURE-----

--=-8FrO+4xcnW7ZisDzcwIY--

