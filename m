Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUEXQAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUEXQAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUEXQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:00:38 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:63140 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S264329AbUEXQAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:00:36 -0400
Date: Mon, 24 May 2004 18:00:26 +0200
From: Malte =?ISO-8859-1?B?U2NocvZkZXI=?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
Message-Id: <20040524180026.07a80c10@highlander.Home.LAN>
Reply-To: MalteSch@gmx.de
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__24_May_2004_18_00_26_+0200_nHe4sVyo1ggJ3F8Z"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__24_May_2004_18_00_26_+0200_nHe4sVyo1ggJ3F8Z
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I build a 64-bit kernel (using gcc 3.3.3) on debian/sid for an Athlon 64 32=
00+. The System has a Radeon 9800pro as graphics card.=20
When playing videos using xine in full PAL-Resolution these videos run chop=
py, top then shows a cpuload of roughly 50% system and 50% user.

Thanks.
--=20
---------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------


--Signature=_Mon__24_May_2004_18_00_26_+0200_nHe4sVyo1ggJ3F8Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAshwd4q3E2oMjYtURAqzJAKDOHSPdhh2ResSZgU5J4GXDO52wtACfSdZy
uzfbGXqsJ1vy0QJ2IH3tass=
=9lf5
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2004_18_00_26_+0200_nHe4sVyo1ggJ3F8Z--
