Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUJGKMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUJGKMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269777AbUJGKMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:12:40 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:3968 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S267370AbUJGKKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:10:51 -0400
Date: Thu, 7 Oct 2004 12:10:48 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Sanders <sandersn@btinternet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041007121048.7953314f@phoebee>
In-Reply-To: <20041007025007.77ec1a44.akpm@osdl.org>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__7_Oct_2004_12_10_48_+0200_z/Cdl4cyN_wvnBjR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__7_Oct_2004_12_10_48_+0200_z/Cdl4cyN_wvnBjR
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 7 Oct 2004 02:50:07 -0700
Andrew Morton <akpm@osdl.org> bubbled:

> Nick Sanders <sandersn@btinternet.com> wrote:
> >
> > On Thursday 07 October 2004 09:51, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
> >  >.9-rc3-mm3/
> >  >
> > 
> >  I get the following oops when booting and it also stops kde
> >  (artswrapper) from starting with the same call trace. USB seems to
> >  be working which is good.
> 
> Could you please do
> 
> 
> cd /usr/src/linux
> wget
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
> patch -R -p1 < optimize-profile-path-slightly.patch
> 
> and retest?

Oops gone! And plaympeg plays my mp3 bootup sound. Great!

But that sttupid nvidia driver still does not work.


-- 
MyExcuse:
Stubborn processes

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__7_Oct_2004_12_10_48_+0200_z/Cdl4cyN_wvnBjR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBZRYqmjLYGS7fcG0RAsLxAJ4l0eBfkdNn16UV6h7C1QVmFhYsKACdG4jK
sSQAGuGAD/xiMx8h0x3tK+c=
=q5lk
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Oct_2004_12_10_48_+0200_z/Cdl4cyN_wvnBjR--
