Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270074AbTGUNn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270090AbTGUNn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:43:56 -0400
Received: from mx02.qsc.de ([213.148.130.14]:31408 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S270074AbTGUNny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:43:54 -0400
Date: Mon, 21 Jul 2003 15:58:44 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Alain BASTIDE <alain.bastide@univ-reunion.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules + 2.6.0
Message-ID: <20030721135844.GF3139@gmx.de>
Reply-To: Johoho <johoho@hojo-net.de>
References: <3F1BEE9C.8080605@univ-reunion.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <3F1BEE9C.8080605@univ-reunion.fr>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm1-O7 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

isn't this FAQ somewhere? Install latest module-init-tools. See
Documentation/Changes for more info

On Mon, Jul 21, 2003 at 05:46:04PM +0400, Alain BASTIDE wrote:
> Hi,
>=20
> 	I'm got a problem ....
> =09
> 	I compile the kernel 2.6.0 bk2 (or ac2). I install the last modutil.
> 	All work, i've got no warrning message or no error massage when it=20
> enter in init 3 .... but when i do : lsmod i see :
>=20
> [root@bipbip boot]# lsmod
> Module                  Size  Used by
> [root@bipbip boot]# lsmod
>=20
> So no modules !!!!! but i should see 3x59x ... nfsd .... lockd ....
>=20
> What happens??????
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Regards,

Wiktor Wodecki

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE/G/GU6SNaNRgsl4MRAp6tAJjRsb3tTsBYxp0HWuQ+p6iCgKKxAJ47Tgpw
+Kui5lLGFieIFmy4qf4l/g==
=A++D
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
