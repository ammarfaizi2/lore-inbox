Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270640AbTGNQgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270636AbTGNQgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:36:39 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:33240 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S270640AbTGNQf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:35:29 -0400
Subject: Re: no sound on 2.5.75-mm1 (emu10k1 loaded)
From: Max Valdez <maxvalde@fis.unam.mx>
To: Patrick Mansfield <patmans@us.ibm.com>,
       kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030714085955.A7342@beaverton.ibm.com>
References: <1058115661.6491.6.camel@garaged.homeip.net>
	 <20030714085955.A7342@beaverton.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ruW/ZyTK2DScbp7xVFgU"
Message-Id: <1058183438.3913.11.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 06:50:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ruW/ZyTK2DScbp7xVFgU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I'm running fine with emu10k1.

Me too !!, now :-)

Zwane pointed me correctly to a devfs problem, and actually was the
AUTOMOUNT_DEVFS feature that was giving me problems, gentoo tries to
mount it too, when it was already mounted.

I guess is time to go to 2.6-test

My system is running perfectly, the only thing I dont like right now is
that my quickcam modules cannot be compiled on 2.5, i will try to fix
that, or test the old 2.4 module on 2.5

Thanks for ur comments Patrick!
Max

--=20
Linux garaged 2.4.22-pre3-ac1 #5 SMP Wed Jul 9 07:01:52 CDT 2003 i686 Penti=
um III (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-ruW/ZyTK2DScbp7xVFgU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EpkOsrSE6THXcZwRAhXOAJ9soKf/KPVFGPnE7S6fypA3DuWmhACglvIn
CN0OZsv3bSeUhW6+dhNvQDM=
=hevB
-----END PGP SIGNATURE-----

--=-ruW/ZyTK2DScbp7xVFgU--

