Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUJRLow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUJRLow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJRLow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 07:44:52 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:56459 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266175AbUJRLot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 07:44:49 -0400
Date: Mon, 18 Oct 2004 13:44:43 +0200
From: Martin Waitz <tali@admingilde.org>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041018114443.GC3618@admingilde.org>
Mail-Followup-To: Kendall Bennett <KendallB@scitechsoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m3655cjc1r.fsf@averell.firstfloor.org> <416FB29A.11731.1C46848@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <416FB29A.11731.1C46848@localhost>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Fri, Oct 15, 2004 at 11:20:58AM -0700, Kendall Bennett wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > It doesn't imply this at all. You set an initial mode with the BIOS
> > during boot up. When your initrd runs you gain the ability to flip mode
> > and do cool stuff - arguably it doesn't even need to be in initrd.
>=20
> That works great on x86, but this solution was developed for PowerPC and=
=20
> MIPS embedded systems development not x86 desktop systems. For those=20
> platforms you either need a boot loader that can bring up the system into=
=20
> graphics mode

not neccessarily.

If anything goes wrong before console is initialized, then that could
be displayed by the firmware.
Is there any arch which doesn't have some basic text-output
functunality in its firmware?

--=20
Martin Waitz

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBc6yqj/Eaxd/oD7IRAnaOAKCBH56JnYRZ6m03gfOHdkUo9kdDrQCfU8O6
lUD+RfPj4/l/TALLVUDgiRk=
=K0SS
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
