Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSGXLNf>; Wed, 24 Jul 2002 07:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSGXLNf>; Wed, 24 Jul 2002 07:13:35 -0400
Received: from [213.69.232.58] ([213.69.232.58]:29962 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S316953AbSGXLNe>;
	Wed, 24 Jul 2002 07:13:34 -0400
Date: Wed, 24 Jul 2002 15:16:43 +0200
From: Nico Schottelius <nicos-mutt@pcsystems.de>
To: Joshua Uziel <uzi@uzix.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpu speed is 165mhz instead of real 650mhz
Message-ID: <20020724131642.GA479@schottelius.org>
References: <20020724110121.GA1925@schottelius.org> <20020724102709.GA17905@uzix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20020724102709.GA17905@uzix.org>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joshua Uziel [Wed, Jul 24, 2002 at 03:27:09AM -0700]:
> * Nico Schottelius <nicos-mutt@pcsystems.de> [020724 02:03]:
> > This periodicly appears in my system. The Kernel seems to misdetect the
> > right cpu speed and then it's running only at 165mhz.
> > I don't really understand why this happens, there's no acpi enabled, wh=
ich
> > caused this failure the last time.
>=20
> Is this a notebook computer?  Is it that you're sometimes booting it up
> while the system is unplugged (ie. on battery)?

yes,it is, but slowing down to 500 mhz is the only  available speedstep
option.

165 or similar is not supported (afaik) by the bios/processor.


Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Pqi6tnlUggLJsX0RAiYpAKCfan65o8nj11PwILVsmMzDZ1fwOgCeLZdk
NLN6iIrlOYnKa6VNGS5rLeU=
=Fxju
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
