Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317730AbSFNFRJ>; Fri, 14 Jun 2002 01:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSFNFRI>; Fri, 14 Jun 2002 01:17:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:2296 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317730AbSFNFRH>;
	Fri, 14 Jun 2002 01:17:07 -0400
Date: Fri, 14 Jun 2002 09:13:53 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7xxx won't compile w/o PCI at all <- fixed
Message-ID: <20020614051353.GB26527@stingr.net>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020613194636.GA26527@stingr.net> <200206132027.g5DKR4968416@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Replying to Justin T. Gibbs:
> I guess I'm missing some context here.

:)

> The patch, on first inspection, appears correct.  Unfortunately, finding
> machines without PCI busses is getting more and more difficult every day,
> but I'll add a build case that disables PCI busses so we catch these kinds
> of failures in the future..

Unfortunately, I just have one such machine here ;(

- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAj0Je5AACgkQyMW8naS07KTklQCfSdoW3LYTOyrx0iUkm3/WnMBs
hp8AoMx0uYc8RmKeYY628xC8RBdfG+H5
=ENeK
-----END PGP SIGNATURE-----
