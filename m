Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUFRWaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUFRWaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265543AbUFRW3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:29:10 -0400
Received: from lists.us.dell.com ([143.166.224.162]:36724 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265300AbUFRW13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:27:29 -0400
Date: Fri, 18 Jun 2004 17:26:51 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hannu Savolainen <hannu@opensound.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618222651.GJ19269@lists.us.dell.com>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local> <40D2464D.2060202@opensound.com> <Pine.LNX.4.58.0406181205500.13079@scrub.local> <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi> <40D3642E.4050509@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
In-Reply-To: <40D3642E.4050509@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2004 at 05:52:46PM -0400, Jeff Garzik wrote:
> Hannu Savolainen wrote:
>=20
> >The actual problem is that there is no standardized way to compile modul=
es
> >outside the kernel source tree. There will be serious problems if
> >different distributions need slightly different installation procedure.
> >Who is going to be able to tell the customer what exactly he should do?
>=20
> In 2.6.x there is a way to do this :)
>=20
> Sam Ravnborg recently posted documentation for this, as well.

<shameless plug>
and we suggest using DKMS for exactly this purpose, until you get your
code merged into the kernel.org trees.  http://linux.dell.com/dkms/
</shameless plug>

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA02wrIavu95Lw/AkRAnRsAJ4mc9IEYo7OJxs5DD0BugaFT0tAOQCfVVSh
zKkeecwEbp8jyBf5oVTOvIc=
=drj9
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
