Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292377AbSBYWli>; Mon, 25 Feb 2002 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292373AbSBYWkT>; Mon, 25 Feb 2002 17:40:19 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:17538 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S292368AbSBYWjN>; Mon, 25 Feb 2002 17:39:13 -0500
Date: Mon, 25 Feb 2002 17:38:52 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 - Full tarball is OK
Message-ID: <20020225223852.GA9212@opeth.ath.cx>
In-Reply-To: <200202252149.g1PLnwe13182@directcommunications.net> <E16fTkG-0006VG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <E16fTkG-0006VG-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2002 at 10:37:20PM +0000, Alan Cox wrote:
> > FYI - The full tarball already has the missing patch...
> > So, I think, it's only patch-2.4.18 that has the problem...
>=20
> Argh thats the worst possible case. That means you can't do a single corr=
ect
> 2.4.18- patch=20
>=20
> If so Marcelo can you put up 2.4.18-fixed patch and a borked-fixed diff ?

cdub_ and I just checked: the 18-final tarball, patch, and incr are all
missing the fix in fs/binfmt_elf.c

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8erz8MwVVFhIHlU4RAtYHAJ9H6uBBZChZhM1RVDUkL/VNaPfnNQCfeZfD
FMc1mhoFREgO90XH5Y9j240=
=WwC4
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
