Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQKLWJt>; Sun, 12 Nov 2000 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131089AbQKLWJj>; Sun, 12 Nov 2000 17:09:39 -0500
Received: from rzcomm4.rz.tu-bs.de ([134.169.9.55]:37648 "EHLO
	rzcomm4.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id <S131016AbQKLWJb>; Sun, 12 Nov 2000 17:09:31 -0500
Date: Sun, 12 Nov 2000 23:14:32 +0100
From: Jochen Striepe <j.striepe@tu-bs.de>
To: "juergen.heisel@planet-heisel.de" <juergen.heisel@planet-heisel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Error linux-2.2.17 and RedHat7.0
Message-ID: <20001112231432.E517@tolot.meuer.de>
In-Reply-To: <E13v59O-0000op-00@mrvdom02.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13v59O-0000op-00@mrvdom02.schlund.de>; from juergen.heisel@planet-heisel.de on Sun, Nov 12, 2000 at 10:51:34PM +0100
X-Editor: vim/5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

        Hi,

On 12 Nov 2000, juergen.heisel@planet-heisel.de <juergen.heisel@planet-heis=
el.de> wrote:
>=20
> I updated my system from RedHat 6.0 -> RedHat 7.0 and Murphy is still
> working.
[...]
>  I can't compile Kernel 2.2.17 since the update.=20
[...]
> Gnu C		       2.96

You do not read the LKML archive, right?

Use gcc 2.95.2 or egcs-1.1.2 and your problems will vanish.
gcc-2.96 is not recommended for kernel building.


Cheers,

Jochen.

--=20
FAQ zur Newsgroup at.linux:
<http://alfie.ist.org/LinuxFAQ/>


--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6DxZHm3eMyUx1sM4RAom+AJ425qNAEfwOFSuTsQUExisNvqh2uACbBeJK
O9C+Iz5oUYwAdhqOxtdiKTM=
=Mv0U
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
