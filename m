Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVERLkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVERLkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVERLkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:40:43 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:61061 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261625AbVERLkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:40:35 -0400
Date: Wed, 18 May 2005 13:40:31 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Filipe Abrantes <fla@inescporto.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
Message-ID: <20050518134031.53a3243a@phoebee>
In-Reply-To: <428B1A60.6030505@inescporto.pt>
References: <428B1A60.6030505@inescporto.pt>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Wed__18_May_2005_13_40_31_+0200_TH8m=ESwG/_K6geF";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__18_May_2005_13_40_31_+0200_TH8m=ESwG/_K6geF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 May 2005 11:35:12 +0100
Filipe Abrantes <fla@inescporto.pt> bubbled:

> Hi all,
>=20
> I need to detect when an interface (wired ethernet) has link up/down.
> Is  there a system signal which is sent when this happens? What is the
> best  way to this programatically?

mii-tool?

--=20
MyExcuse:
Not enough interrupts

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature_Wed__18_May_2005_13_40_31_+0200_TH8m=ESwG/_K6geF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCiymwmjLYGS7fcG0RArm0AKCfJ6VI09uTTeWt5n91+ToNScCQRACdG3Tc
hT+4FSZPFYRt7r5TO5tmNWo=
=j43W
-----END PGP SIGNATURE-----

--Signature_Wed__18_May_2005_13_40_31_+0200_TH8m=ESwG/_K6geF--
