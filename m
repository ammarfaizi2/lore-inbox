Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWHWOf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWHWOf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWHWOf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:35:59 -0400
Received: from nsm.pl ([195.34.211.229]:40975 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S964904AbWHWOf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:35:58 -0400
Date: Wed, 23 Aug 2006 16:35:53 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unexpected kernel messages for Sun Fire X4100 (NUMA Opteron 64bit) with SLES10
Message-ID: <20060823143553.GA2212@irc.pl>
Mail-Followup-To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	linux-kernel@vger.kernel.org
References: <44EC7AC0.12128.6635514@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <44EC7AC0.12128.6635514@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2006 at 03:56:47PM +0200, Ulrich Windl wrote:
> I'm currently evaluating Novell/SUSE Enterprise Server 10 (SLES10) on a S=
un Fire=20
> X4100.
> That machine basically features two Dual-Core AMD Opteron CPUs with 8GB R=
AM each.=20
> I'm running the latest SLES10 kernel (2.6.16.21-0.15-smp #1 SMP Tue Jul 2=
5=20
> 15:28:49 UTC 2006 x86_64 x86_64 x86_64 GNU/Linux) and the latest firmware=
 for the=20
> hardware (Sun seems not to produce a lot of those however: The Service Pr=
ocessor=20
> still runs with "Linux version 2.4.22").

  Are you sure you have latest BIOS installed? From
http://www.sun.com/download/products.xml?id=3D44cfd445 :
 BIOS 34 (0ABGA034). The improvements are:
    (...)
    * AMD PowerNow support

  Also, you may try if acpi-cpufreq modules works for you.


--=20
Tomasz Torcz                        To co nierealne -- tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na =BFycie maj=B1 tu patenty spe=
cjalne.


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFE7GfJ10UJr+75NrkRAp7IAKCKxm4JYm5/xiGnCS3Xp2cJDnERfACdEdlO
Q6ti/o0wx09tPAUTNGYYrEU=
=iP+H
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
