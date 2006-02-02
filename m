Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423374AbWBBIOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423374AbWBBIOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423375AbWBBIOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:14:05 -0500
Received: from smtp05.auna.com ([62.81.186.15]:960 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1423374AbWBBIOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:14:04 -0500
Date: Thu, 2 Feb 2006 09:19:00 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jiri Slaby <xslaby@fi.muni.cz>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
Message-ID: <20060202091900.469e7394@werewolf.auna.net>
In-Reply-To: <1138863107.3270.8.camel@laptopd505.fenrus.org>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	<Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
	<1138810616.16643.30.camel@tara.firmix.at>
	<1138863107.3270.8.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs2 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig__gOJl3Txmz=c/Pka7mA0WDX";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Thu, 2 Feb 2006 09:14:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig__gOJl3Txmz=c/Pka7mA0WDX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 02 Feb 2006 07:51:47 +0100, Arjan van de Ven <arjan@infradead.org> =
wrote:

> On Wed, 2006-02-01 at 17:16 +0100, Bernd Petrovitsch wrote:
> > On Wed, 2006-02-01 at 17:14 +0100, Jan Engelhardt wrote:
> > [...]
> > > >change root=3DLABEL=3D/ to root=3D/dev/XXX. Vanilla doesn't support =
this...
> > > >
> > > is there a kernel patch that does allow it?
> >=20
> > Yes, in RedHat's/Fedora's kernels since ages.
>=20
> wrong.
> there is NO kernel patch for this. Not in RHs and not in Fedora's
> kernel.
> Never was either.
> it's 100% done in the initrd.
>=20

Isn't this a matter of the bootloader ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam7 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig__gOJl3Txmz=c/Pka7mA0WDX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4cB0RlIHNEGnKMMRAnWfAKCbVVz6qkZss6wSU+DTrRnhib+cxACfXSnK
A5VvJKSDvk8tyMbmeX62OR4=
=F/SX
-----END PGP SIGNATURE-----

--Sig__gOJl3Txmz=c/Pka7mA0WDX--
