Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTGPA5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269983AbTGPA5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:57:53 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:65498 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S269981AbTGPA5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:57:51 -0400
Subject: Re: modules problems with 2.6.0 (module-init-tools-0.9.12)
From: Max Valdez <maxvalde@fis.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716021210.56ea8360.diegocg@teleline.es>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
	 <20030715152257.614d628b.rddunlap@osdl.org>
	 <1058313192.21300.988.camel@www.piet.net>
	 <20030716021210.56ea8360.diegocg@teleline.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hSQeNGu7Wr07OACzVvv0"
Message-Id: <1058299988.5432.14.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 15:13:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hSQeNGu7Wr07OACzVvv0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gentoo works too, with 2.5 and 2.6, 2.4 works as expected, like before
installing the devel kernels

:-)

Im going for the first day of uptime with 2.6, and no problem at all

Max
On Tue, 2003-07-15 at 19:12, Diego Calleja Garc=EDa wrote:
> El 15 Jul 2003 16:53:12 -0700 Piet Delaney <piet@www.piet.net> escribi=F3=
:
>=20
> > On Tue, 2003-07-15 at 15:22, Randy.Dunlap wrote:
> >=20
> > I heard that if you install the new module-init-tools package in
> > /sbin that you would be able to boot old kernels. Is that true?
>=20
> It works here.
> i've a debian distro, i apt-get'ed module-init-tools. Man modprobe says:
>=20
> BACKWARDS COMPATIBILITY
>        This version of insmod is  for  kernels  2.5.48  and  above.   If =
 it
>        detects  a kernel with support for old-style modules (for which mu=
ch of
>        the work was done in userspace), it will attempt to run  insmod.mo=
du-
>        tils in its place, so it is completely transparent to the user.
>=20
> diego@estel:~$ ls -l /sbin/insmod*
> -rwxr-xr-x    1 root     root         5072 2003-06-15 12:27 /sbin/insmod
> -rwxr-xr-x    1 root     root          359 2003-03-06 15:50 /sbin/insmod_=
ksymoops_clean
> -rwxr-xr-x    1 root     root        95372 2003-03-06 15:50 /sbin/insmod.=
modutils
>=20
>=20
> Looking at the size, insmod.modutils seems the 2.4 insmod loader.=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Linux garaged 2.4.22-pre3-ac1 #5 SMP Wed Jul 9 07:01:52 CDT 2003 i686 Penti=
um III (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-hSQeNGu7Wr07OACzVvv0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FGBUsrSE6THXcZwRAlObAJ4k85ctWjEih73gDDCLLj4M8cGqBACfZIpp
Chjbeu5Nbaom5GEIyuFMxBo=
=+ge0
-----END PGP SIGNATURE-----

--=-hSQeNGu7Wr07OACzVvv0--

