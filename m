Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUCKNXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUCKNXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:23:33 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:22656 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261292AbUCKNXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:23:24 -0500
Date: Thu, 11 Mar 2004 14:23:15 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: NVIDIA and 2.6.4?
Message-Id: <20040311142315.21c3b928@phoebee>
In-Reply-To: <20040311131027.051055D9A@mx.ktv.lt>
References: <20040311123100.GE17760@rdlg.net>
	<20040311131027.051055D9A@mx.ktv.lt>
X-Mailer: Sylpheed version 0.9.10claws2 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__11_Mar_2004_14_23_15_+0100_Epm5KCkYqEPQZK0d"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__11_Mar_2004_14_23_15_+0100_Epm5KCkYqEPQZK0d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 11 Mar 2004 15:07:03 +0200 (EET)
Nerijus Baliunas <nerijus@users.sourceforge.net> bubbled:

> On Thu, 11 Mar 2004 07:31:00 -0500 "Robert L. Harris"
> <Robert.L.Harris@rdlg.net> wrote:
> 
> > And that's just for starters.  Does anyone know if there's a way to get
> > this to compile cleanly or is it SoL until a new driver is released
> > (running 1.0.4191 currently).
> 
> At least for x86 the latest driver (1.0-5336) is compatible with 2.6.x
> (didn't test on 2.6.4 though).

nvidia 5336 works with 2.6.4 here. (but it has a basic sysfs patch
applied by gentoo)

Regards,
Martin

-- 
MyExcuse:
kernel panic: write-only-memory (/dev/wom0) capacity exceeded.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__11_Mar_2004_14_23_15_+0100_Epm5KCkYqEPQZK0d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUGhFmjLYGS7fcG0RAvPhAJ0RVm+JbOtU7eKEeomNiIJ0gR031gCfVqDC
OTRgmy6tv8Vrh7VDKXDjkJ8=
=73eF
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Mar_2004_14_23_15_+0100_Epm5KCkYqEPQZK0d--
