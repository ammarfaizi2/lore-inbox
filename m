Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTKGWd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTKGW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22742 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264171AbTKGV7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:39 -0500
Subject: Re: [Bug 1412] Copy from USB1 CF/SM reader stalls, no actual
	content is read (only directory structure)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1068238928.4088.2.camel@m70.net81-64-235.noos.fr>
References: <20031105084002.GX1477@suse.de>
	 <Pine.LNX.4.44L0.0311051013190.828-100000@ida.rowland.org>
	 <20031107082439.GB504@suse.de> <1068195038.21576.1.camel@ulysse.olympe.o2t>
	 <20031107090924.GB616@suse.de>
	 <1068197144.21576.32.camel@ulysse.olympe.o2t>
	 <1068238928.4088.2.camel@m70.net81-64-235.noos.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kN2nZnAKa7mipPvEjgid"
Organization: Adresse personelle
Message-Id: <1068239039.4088.5.camel@m70.net81-64-235.noos.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Nov 2003 22:03:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kN2nZnAKa7mipPvEjgid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 07/11/2003 =E0 22:02, Nicolas Mailhot a =E9crit :
> Le ven 07/11/2003 =E0 10:25, Nicolas Mailhot a =E9crit :
> > Le ven 07/11/2003 =E0 10:09, Jens Axboe a =E9crit :
>=20
> > > Try with this debug patch then, does it work now?

[...]

> > Will try this evening when I have physical access to the system. (It's
> > difficult to plug a USB device via ssh;)
>=20
> Well, it does work now (couldn't believe my eyes, tried three times in a
> row just to be sure). Is this supposed to be a definitive fix that will
> be in the next bk snapshots or should I wait for something else ?

Thanks a lot everyone btw - I'm so shocked I'm forgetting my manners;)

--=20
Nicolas Mailhot

--=-kN2nZnAKa7mipPvEjgid
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/rAi/I2bVKDsp8g0RAgpMAJ93sQkPAVMCl3he5oFqs3nz3Ff1VgCcDw1o
ScbAcIkYkqw1O/kCWSGzjWg=
=8DdW
-----END PGP SIGNATURE-----

--=-kN2nZnAKa7mipPvEjgid--

