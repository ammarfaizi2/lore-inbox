Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSHBJhJ>; Fri, 2 Aug 2002 05:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSHBJhJ>; Fri, 2 Aug 2002 05:37:09 -0400
Received: from [213.69.232.58] ([213.69.232.58]:8459 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318764AbSHBJhI>;
	Fri, 2 Aug 2002 05:37:08 -0400
Date: Fri, 2 Aug 2002 05:59:25 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Message-ID: <20020802035925.GE2236@schottelius.org>
References: <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk> <20020731175743.GB1249@schottelius.org> <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk> <5.1.0.14.2.20020801134624.00aabec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020801134624.00aabec0@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Btw, it was not a NTFS problem, just watched wrong!
It seems to be a general problem in the fs tree with devfs.

I am currently applying the console patch, but this doesn't fix the
error I posted in the last mail.

If I have some more time, I will try to fix it myself...

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SgOdtnlUggLJsX0RAtE9AJ9ezjdPeq5k0eZFYy/YRqC4aRfGMACgnmsL
+yCJIsuYes0TJhLXm3H5vdw=
=x8he
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
