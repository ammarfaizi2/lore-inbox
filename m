Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWCQJfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWCQJfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWCQJfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:35:33 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:974 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751195AbWCQJfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:35:32 -0500
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Takashi Sato <sho@bsd.tnes.nec.co.jp>, Mingming Cao <cmm@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20060316183549.GK30801@schatzie.adilger.int>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
	 <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com>
	 <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp>
	 <20060316183549.GK30801@schatzie.adilger.int>
Message-Id: <1142588127.22660.1.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Fri, 17 Mar 2006 10:35:27 +0100
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/03/2006 10:37:15,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/03/2006 10:37:16,
	Serialize complete at 17/03/2006 10:37:16
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DNQzp71X4ut2fL3fAgxz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DNQzp71X4ut2fL3fAgxz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le jeu 16/03/2006 =C3=A0 19:35, Andreas Dilger a =C3=A9crit :
[...]
> Laurent, do your 64-bit patches include support for larger i_blocks?

No, I only work on extending the filesystem size. Extending the file
size will be the next step...

Cheers,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-DNQzp71X4ut2fL3fAgxz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBEGoLf9Kffa9pFVzwRAg+6AJ9wAuSaDQqUkLOf6XlGRagcbpoKDgCg2P6+
lmQIIyX23uqCKvA0XhFGo5U=
=cdID
-----END PGP SIGNATURE-----

--=-DNQzp71X4ut2fL3fAgxz--

