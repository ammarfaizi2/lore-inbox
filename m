Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTJYRfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTJYRfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:35:21 -0400
Received: from h-68-164-243-10.SNVACAID.covad.net ([68.164.243.10]:42429 "EHLO
	mail.cryptobackpack.org") by vger.kernel.org with ESMTP
	id S262746AbTJYRfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:35:15 -0400
Date: Sat, 25 Oct 2003 10:35:04 -0700
From: David Bryson <david@tsumego.com>
To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Tyan S2466 and 3ware Lockup
Message-ID: <20031025173504.GC11472@heliosphan.in.cryptobackpack.org>
Reply-To: David Bryson <david@tsumego.com>
References: <Pine.LNX.4.44.0310222046321.4347-100000@puma.cabm.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310222046321.4347-100000@puma.cabm.rutgers.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2003 at 08:54:25PM -0400 or thereabouts, Ananda Bhattachary=
a wrote:
> I have read Vincent Touquet  about the Tyan motherboard and=20
> the 3ware problems that cause a lockup. He believes that=20
> this is due to dma causing the PCI bus to overload and then=20
> the system crashes. I am running a similar system with=20
> a National Semiconducotrs GigaBit Card and then there is a=20
> 3-ware card with 12 disks on it. I believe to fix this=20
> problem is to use dma=3Doff as a boot option. Does anyone have=20
> another idea, or an exact idea why lockups like this happen?
> I have not as of yet used the dma=3Doff option myself.=20
> thank you=20

I run at least 12+ machines with a similar configuration(Tyan S2466
dual athon w/3ware controllers). And I have been testing heavy loads
with them for over a year and not seen anything related to what you describ=
e.
But, I do not use NatSemi network cards, mostly Broadcom Gbit
cards(tg3 driver) and some intel e1000 Gbit cards.  Maybe the problem is
your network card ?


--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/mrRILfsM4nS2FiARAtyQAJ4tK7ghcdtgJGAF9NGCvUEJDz3lXgCgkvkS
qC5P5b1rQu73ruwLWNwxBmw=
=tqC6
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
