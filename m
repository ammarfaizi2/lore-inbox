Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264633AbSJTTfL>; Sun, 20 Oct 2002 15:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264634AbSJTTfL>; Sun, 20 Oct 2002 15:35:11 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:7033 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264633AbSJTTfK>;
	Sun, 20 Oct 2002 15:35:10 -0400
Date: Sun, 20 Oct 2002 21:41:10 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Error in get_swap_page? (2.5.44)
Message-ID: <20021020214110.A18581@jaquet.dk>
References: <20021020213217.A17457@jaquet.dk> <6ud6q4x5pt.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6ud6q4x5pt.fsf@zork.zork.net>; from sneakums@zork.net on Sun, Oct 20, 2002 at 08:36:46PM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2002 at 08:36:46PM +0100, Sean Neakums wrote:
> commence  Rasmus Andersen quotation:
>=20
> > Unless I am mistaken, we return stuff (entry) from the local=20
> > stack in swapfile.c::get_swap_page. Am I mistaken?
>=20
> Wouldn't this only be a problem if a *pointer* to it was being
> returned?

Quite. Sorry about that. I'll be a good boy and go to bed now :)

Regards,
  Rasmus

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9swbWlZJASZ6eJs4RAmDBAJ9TWZsfbIEeth7ClB8ge/rPkZQIrQCfVhF9
FjA4H5eBxmXRyJq60G2keDQ=
=u+ah
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
