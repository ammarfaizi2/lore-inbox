Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVLNAPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVLNAPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVLNAPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:15:31 -0500
Received: from smtp04.auna.com ([62.81.186.14]:44173 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1030326AbVLNAP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:15:29 -0500
Date: Wed, 14 Dec 2005 01:17:38 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051214011738.6c05dc1f@werewolf.auna.net>
In-Reply-To: <20051213152450.733aff26.akpm@osdl.org>
References: <20051204232153.258cd554.akpm@osdl.org>
	<20051213234918.456131df@werewolf.auna.net>
	<20051213152450.733aff26.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs86 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_gCl2TU=QcEe/ZL+1ab749_D";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Wed, 14 Dec 2005 01:15:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_gCl2TU=QcEe/ZL+1ab749_D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Dec 2005 15:24:50 -0800, Andrew Morton <akpm@osdl.org> wrote:

> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:
> >=20
> > >=20
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-=
rc5/2.6.15-rc5-mm1/
> > >=20
> >=20
> > mmm, this patch GPL'ed all pci_xxxxxx functions, so it broke what you
> > all know.
>=20
> That'll be gregkh-pci-shot-accross-the-bow.patch.
>=20
> > Final attack against binary drivers ? Or just an API change ?
>=20
> A joke, I believe.

:))
Thanks.

BTW, is there any easy way to get a reverse patch, apart from patch -R
and rediff ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam4 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_gCl2TU=QcEe/ZL+1ab749_D
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDn2SiRlIHNEGnKMMRArrWAJ95wpE0LCp98SqpCvMp8uyzfmGx7ACfdVsk
bTjAFvp91XQXEh+ihN/ZwUM=
=RxKy
-----END PGP SIGNATURE-----

--Sig_gCl2TU=QcEe/ZL+1ab749_D--
