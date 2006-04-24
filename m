Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWDXV2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWDXV2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDXV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:28:39 -0400
Received: from smtp05.auna.com ([62.81.186.15]:24969 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1750971AbWDXV2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:28:11 -0400
Date: Mon, 24 Apr 2006 23:28:04 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Martin Mares <mj@ucw.cz>, Gary Poppitz <poppitzg@iomega.com>,
       linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Message-ID: <20060424232804.37c41a52@werewolf.auna.net>
In-Reply-To: <444D44F2.8090300@wolfmountaingroup.com>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	<mj+md-20060424.201044.18351.atrey@ucw.cz>
	<444D44F2.8090300@wolfmountaingroup.com>
X-Mailer: Sylpheed-Claws 2.1.1cvs22 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_YWirNARL1AY2XeTc7zrn..W;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Mon, 24 Apr 2006 23:28:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_YWirNARL1AY2XeTc7zrn..W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Apr 2006 15:36:50 -0600, "Jeff V. Merkey" <jmerkey@wolfmountaing=
roup.com> wrote:

Ahhh, I use to trash this discussions until I see something like this...

> Martin Mares wrote:
>=20
> All of the hidden memory allocations from constructor/destructor=20
> operatings can and do KILL OS PERFORMANCE.

FUD. Learn to write C++.

> Java
> is a great example as to why kernel OS code should NEVER be allowed in C+=
+.
>=20

Java and C++ are like apples and oranges.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam9 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue

--Sig_YWirNARL1AY2XeTc7zrn..W
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFETULkRlIHNEGnKMMRAnuMAKCidqNFD9J3g+icTV1svDEM/7zEpgCfd1fU
lK6xsbw8IO9FMnyVfg0i4ng=
=ZQAW
-----END PGP SIGNATURE-----

--Sig_YWirNARL1AY2XeTc7zrn..W--
