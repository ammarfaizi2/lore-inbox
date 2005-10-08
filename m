Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVJHWrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVJHWrG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 18:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVJHWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 18:47:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:19668 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932185AbVJHWrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 18:47:04 -0400
X-Authenticated: #20450766
Date: Sun, 9 Oct 2005 00:35:37 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
In-Reply-To: <20051001211543.GB6397@ime.usp.br>
Message-ID: <Pine.LNX.4.60.0510090031550.16544@poirot.grange>
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net>
 <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br>
 <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
 <Pine.LNX.4.60.0509272139220.18464@poirot.grange> <20051001211543.GB6397@ime.usp.br>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1825112379-1128810785=:16544"
Content-ID: <Pine.LNX.4.60.0510090033200.16544@poirot.grange>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1825112379-1128810785=:16544
Content-Type: TEXT/PLAIN; CHARSET=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0510090033201.16544@poirot.grange>

Hi Rog=E9rio,

Sorry, was away for a week.

On Sat, 1 Oct 2005, [iso-8859-1] Rog=E9rio Brito wrote:

> > Try removing the 256MB module?...
>=20
> Right now, I'm only using one 512MB module, but after I have already
> paid for the second one, and it wasn't cheap. :-(

Wasn't it 512 + 512 + 256 MB modules that you had? I just suggested=20
removing only one 256MB module and testing with 2 x 512MB. Which on the=20
one hand wouldn't be that bad as only having 512MB, and on the other hand=
=20
just for a test...

Good luck
Guennadi
---
Guennadi Liakhovetski
---1463811839-1825112379-1128810785=:16544--
