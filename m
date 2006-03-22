Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWCVIlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWCVIlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWCVIlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:41:45 -0500
Received: from smtp04.auna.com ([62.81.186.14]:52938 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1751107AbWCVIlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:41:44 -0500
Date: Wed, 22 Mar 2006 09:41:36 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-mm2
Message-ID: <20060322094136.47b12335@werewolf.auna.net>
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
References: <20060318044056.350a2931.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs160 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_=s7j4UCbSM_riWoFkLjKM5F";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Wed, 22 Mar 2006 09:41:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_=s7j4UCbSM_riWoFkLjKM5F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Mar 2006 04:40:56 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/=
2.6.16-rc6-mm2/
>=20
>=20
> - John's time rework patches were dropped - they're being reworked.
>=20
> - Lots of MD and DM updates
>=20

Mmmm, somthing strange is in this kernel. Is hangs the box in the middle
of the night, it looks like it got stuck on the scsi disk on an AHC
controller...I get no info on syslog.

Are there any changes in aic drivers ? It also has a raid array, perhaps
some change in md code is borking when cron jobs are run in the night...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam20 (gcc 4.0.3 (4.0.3-1mdk for Mandriva Linux release 2006.1=
))

--Sig_=s7j4UCbSM_riWoFkLjKM5F
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIQ3ARlIHNEGnKMMRAirEAJ9li+/+sRsGkIjNnl9K6SWa40gdygCff5wP
McgC5QrQ6HOjYdlb2Y6X++c=
=fj6s
-----END PGP SIGNATURE-----

--Sig_=s7j4UCbSM_riWoFkLjKM5F--
