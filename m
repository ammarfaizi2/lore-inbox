Return-Path: <linux-kernel-owner+w=401wt.eu-S932857AbXABLbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbXABLbt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbXABLbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:31:48 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:28336 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932848AbXABLbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:31:46 -0500
X-Greylist: delayed 1600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 06:31:46 EST
Date: Tue, 2 Jan 2007 14:04:32 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Avuton Olrich" <avuton@gmail.com>
Cc: LMKL <linux-kernel@vger.kernel.org>
Subject: Re: Device does not have a release() function
Message-ID: <20070102140432.3f076f92@localhost.localdomain>
In-Reply-To: <3aa654a40612301612g4702e2cs4fba5151170183b@mail.gmail.com>
References: <3aa654a40612301612g4702e2cs4fba5151170183b@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.5.6cvs10 (GTK+ 2.10.6; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_HbKac4bNlf180w_zGe1H+cg;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_HbKac4bNlf180w_zGe1H+cg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Avuton,

Thanks for this report,=20

> Please excuse me if this has already been discussed. Anything else
> that's needed please let me know.
>=20
> kernel: Linux version 2.6.20-rc2 (sbh@rocket) (gcc version 4.1.1
> (Gentoo 4.1.1-r3)) #6 SMP PREEMPT Thu Dec 28 21:07:58 PST 2006
>=20
> Spotted this in the dmesg:
[...]

Maybe some additional failure case is not handled, I'll have a look at it.

--
Sincerely, Vitaly

--Sig_HbKac4bNlf180w_zGe1H+cg
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFmjxBuOg9JvQhSEsRAlH3AJ0YEfLVaBBl7RxoRyeEWZlYokglPACfRswE
egBLVOUSzcCvLC3IwaM0Ho8=
=84l4
-----END PGP SIGNATURE-----

--Sig_HbKac4bNlf180w_zGe1H+cg--
