Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVLMWrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVLMWrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVLMWrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:47:18 -0500
Received: from smtp05.auna.com ([62.81.186.15]:21996 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1030327AbVLMWrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:47:17 -0500
Date: Tue, 13 Dec 2005 23:49:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051213234918.456131df@werewolf.auna.net>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
References: <20051204232153.258cd554.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs86 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aJi+0xRg1v=J8EN_1JUM9V";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Tue, 13 Dec 2005 23:47:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aJi+0xRg1v=J8EN_1JUM9V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/=
2.6.15-rc5-mm1/
>=20

mmm, this patch GPL'ed all pci_xxxxxx functions, so it broke what you
all know.

Final attack against binary drivers ? Or just an API change ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam4 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_/aJi+0xRg1v=J8EN_1JUM9V
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDn0/uRlIHNEGnKMMRAqj6AJ9qj3T3/PHqUVoEAEBgCcx+o6TuTQCdGHHV
vQszHMNVB9kq7kInoQQE4fo=
=S/nM
-----END PGP SIGNATURE-----

--Sig_/aJi+0xRg1v=J8EN_1JUM9V--
