Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTLBUmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTLBUmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:42:19 -0500
Received: from imap.gmx.net ([213.165.64.20]:12420 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264377AbTLBUlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:41:52 -0500
X-Authenticated: #14985714
Date: Tue, 2 Dec 2003 21:38:53 +0100
From: "Stefan J. Betz" <stefan_betz@gmx.net>
To: burton windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/linux/version.h
References: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org> <Pine.LNX.4.58.0312021447160.896@morpheus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312021447160.896@morpheus>
User-Agent: Mutt/1.3.28i
X-Operating-System: Debian GNU/Linux 3.0r1
X-Programming-Language: Python
X-Office-Software: OpenOffice 1.1.0
X-Nickname: [ENC]BladeXP
X-Kernel-Version: 2.4.22
X-Desktop: FVWM 2.4.6
X-Jabber-Id: stefan_betz@jabber.org
X-Host: encbladexp.homelinux.net
Message-Id: <S264377AbTLBUlw/20031202204209Z+2518@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am Tue, Dec 02, 2003 um 20:47:44 CET, burton windle schrieb:
> I believe include/linux/version.h gets dynamically generated.
>=20
> What does the Makefile say for the version? Everything gets its numbers
> from the Makefile.

Oh... Ups...

Why i have never readed that a simple "make distclean" does make such
things :-(

I have now maked a "make distclean", and now all is correct...

Sorry for consuming our time...

Thanks for all...

--=20
Das Telefonnetz... Unendliche Weiten... Dies sind die Abenteuer eines
genervten Internet-Surfers... Weit von zu Hause entfernt st=F6=DFt er in
Bereiche des Systems vor, die vorher noch niemand gesehen hat...

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iEYEARECAAYFAj/M+F0ACgkQYnMYCLxgMrziZgCeO/7MWmh3eGptGBtwOfASZ0uI
2TQAnjVZgZu+Zjt5IkRX82c0wdPqY3E2
=EKp9
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
