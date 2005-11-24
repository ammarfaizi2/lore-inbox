Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVKXAUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVKXAUA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVKXAT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:19:59 -0500
Received: from smtp06.auna.com ([62.81.186.16]:43719 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1030530AbVKXAT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:19:57 -0500
Date: Thu, 24 Nov 2005 01:20:27 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc2-mm1
Message-ID: <20051124012027.228d5e2f@werewolf.auna.net>
In-Reply-To: <20051123033550.00d6a6e8.akpm@osdl.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs29 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_lLmiyfHb0UdCswMQpZgeacI;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.105] Login:jamagallon@able.es Fecha:Thu, 24 Nov 2005 01:19:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_lLmiyfHb0UdCswMQpZgeacI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Nov 2005 03:35:50 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/=
2.6.15-rc2-mm1/
>=20
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.15-rc2-=
mm1.gz)
>=20
> - Added git-sym2.patch to the -mm lineup: updates to the sym2 scsi driver
>   (Matthew Wilcox). =20
>=20
> - The JSM tty driver still doesn't compile.
>=20
> - The git-powerpc tree is included now.
>=20

Bad news :(.
It hangs when trying to start cups.
My initscripts just say "Loading USB printer module" and hang there.
No sysrq-t, no sysrq-b.
I suppose it tries to load usblp.

Any idea about the patch to blame ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam3 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_lLmiyfHb0UdCswMQpZgeacI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhQdLRlIHNEGnKMMRAgb3AJ9MApsef/V8+i8tvIPDfU8d4wg/pgCgr3nq
RwTAZ6l0MFFSl/CHb+o+oYs=
=LuzB
-----END PGP SIGNATURE-----

--Sig_lLmiyfHb0UdCswMQpZgeacI--
