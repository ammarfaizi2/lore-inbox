Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSGWNZD>; Tue, 23 Jul 2002 09:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGWNZD>; Tue, 23 Jul 2002 09:25:03 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:61706 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S317855AbSGWNZC>;
	Tue, 23 Jul 2002 09:25:02 -0400
Date: Tue, 23 Jul 2002 15:28:11 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5.26 - arch/alpha
Message-ID: <20020723132811.GX8891@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200207211354.g6LDsADU005586@alder.intra.bruli.net> <3D3D6B3B.25754.1392D3FD@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7QJU8Gl1+/xsYtC"
Content-Disposition: inline
In-Reply-To: <3D3D6B3B.25754.1392D3FD@localhost>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H7QJU8Gl1+/xsYtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-07-23 14:42:03 +0200, Martin Brulisauer <martin@uceb.org>
wrote in message <3D3D6B3B.25754.1392D3FD@localhost>:
> On 21 Jul 2002, at 18:57, Oliver Pitzeier wrote:
> > Oh... I did... :o( :o) But it's currently a mission
> > impossible. The last kernel running fine for my alpha
> > is 2.5.18 (with a lot of patches...)

There was a quite good patch sent to l-k some weeks ago which
(basically) still applies. I'm using this one (with watering eyes
waiting for a compileable Linus-Kernel...).

> Is there anybody who is willing to test such a patch
> on different alpha's (I only have some XLT's, an AS800
> and one AS250, so all alcor based systems with
> ISA and PCI but without EISA and all are using sys_alcor.c)?
> Further I can't test SMP with this _very_ old hardware.

I cannot test SMP either (I've not got a SMP alpha), but I can test on
Miata, Avanit and NoName.

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--H7QJU8Gl1+/xsYtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PVnrHb1edYOZ4bsRAkTwAJ9w0EJo+ZjVJ6DzGbc+B0vmjNxM9gCfaRvz
9c50CghX0FVYnf5SqULquT4=
=Xs+t
-----END PGP SIGNATURE-----

--H7QJU8Gl1+/xsYtC--
