Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTLWQLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLWQLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:11:55 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:29577 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261892AbTLWQLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:11:51 -0500
Date: Tue, 23 Dec 2003 16:07:04 +0100
From: Arnaud Fontaine <dsdebian@free.fr>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.23
Message-ID: <20031223150704.GA19243@scrappy>
References: <3FE732A7.60402@wanadoo.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <3FE732A7.60402@wanadoo.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2003 at 07:06:31PM +0100, Xose Vazquez Perez wrote:
> > Sorry, i forgot to tell if i had error. So after 11 pass, i have had no
> > error. I have also test with cpuburn which printed nothing after 30
> > minutes.
>=20
> disable the SWAP, and run three burnMMX for 30 minutes:
>=20
> # swapoff -a
> $ ./burnMMX P || echo $? &

Hello,

Do i ran burnMMX during more than 30 minutes and nothing reported. Do
you have an other idea ?

Thanks for your help.
Arnaud

--=20
Arnaud Fontaine <arnaud@andesi.org> - http://www.andesi.org/
GnuPG Public Key available on pgp.mit.edu
Fingerprint: D792 B8A5 A567 B001 C342 2613 BDF2 A220 5E36 19D3

--
Make sure input cannot violate the limits of the program.
            - The Elements of Programming Style (Kernighan & Plaugher)

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6FoYvfKiIF42GdMRAsZEAKCgqsJopSNOwOVra3dRsx94ecbo3QCeJrMf
iOD4PXHpdGDFs4dT4J5t6tA=
=d9hI
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
