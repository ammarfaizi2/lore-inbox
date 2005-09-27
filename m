Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVI0UMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVI0UMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVI0UMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:12:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:5067 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751011AbVI0UMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:12:05 -0400
X-Authenticated: #20450766
Date: Tue, 27 Sep 2005 21:42:44 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
In-Reply-To: <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
Message-ID: <Pine.LNX.4.60.0509272139220.18464@poirot.grange>
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net>
 <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br>
 <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1944732593-1127850014=:18464"
Content-ID: <Pine.LNX.4.60.0509272140340.18464@poirot.grange>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1944732593-1127850014=:18464
Content-Type: TEXT/PLAIN; CHARSET=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0509272140341.18464@poirot.grange>

Hi

On Tue, 27 Sep 2005, Grzegorz Kulewski wrote:

> On Tue, 27 Sep 2005, Rog=E9rio Brito wrote:
>=20
> > The southbridge is a VIA VT82C686.
>=20
> I know. I had the same southbridge in my Abit KG7 but I don't know if you=
 have
> version A or version B. I had version B and it has several disk problems
> fixed. For version A there are some workarounds in the kernel.

Version B here. It first had only 128MB, worked fine, I added 256MB,=20
system become unstable, memtest86 found "bad memory" around the last=20
megabytes. Then I bought 512MB, hoping to use it with 256MB - no way.=20
Every module alone works, but not together. But in my case memtest86 did=20
find errors. Try removing the 256MB module?...

Thanks
Guennadi
---
Guennadi Liakhovetski
---1463811839-1944732593-1127850014=:18464--
