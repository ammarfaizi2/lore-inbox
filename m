Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270714AbTG0KDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270716AbTG0KDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:03:20 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:65309 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id S270714AbTG0KDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:03:16 -0400
Date: Sun, 27 Jul 2003 12:18:42 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Claas Langbehn <claas@rootdir.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test1-ac3: alsa snd_via82xx
Message-ID: <20030727101842.GA21556@gentoo.lan>
Mail-Followup-To: Claas Langbehn <claas@rootdir.de>,
	linux-kernel@vger.kernel.org
References: <20030727091729.GB870@rootdir.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20030727091729.GB870@rootdir.de>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux gentoo.lan 2.6.0-test1-ac3
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>> I figured out some strange behaviour of the alsa drivers in kernel
>> 2.6.0-test1-ac3.=20
>> When compiling everything into the kernel (=3Dy), I was not able to get
>> sound out of my machine at all. But with CONFIG_SND_VIA82XX=3Dm it worke=
d.
>> Isn't that strange?
>> I have got an EPOX 8K9A9i Mainboard with VIA8233 / ALC650 audio.
>> I attach more info below.

Look in the documentation in
Documentation/sound/alsa/ALSA-Configuration.txt

I had the same problem of you, and in reading this "manual", you can
install the module for your sound card, and it works.

If you want details, i can send you my /etc/modules.conf

Stephane
--=20
Stephane Wirtel <stephane.wirtel@belgacom.net>
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/I6cCPRHlvMnBbacRAmdwAJ9MlEIchOTONI+5sFUPFiWnHVPY7ACfT7+b
yjNwqY1wvM/dkv1v3h8eJcs=
=0sfy
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

