Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSFHKl1>; Sat, 8 Jun 2002 06:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSFHKl0>; Sat, 8 Jun 2002 06:41:26 -0400
Received: from stingr.net ([212.193.32.15]:5248 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S317398AbSFHKlZ>;
	Sat, 8 Jun 2002 06:41:25 -0400
Date: Sat, 8 Jun 2002 14:41:23 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Owens <kaos@ocs.com.au>
Subject: [ANNOUNCE] Resync with kbuild 2.5
Message-ID: <20020608104123.GA369@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Keith Owens <kaos@ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild25-3.0-for-2.4.19-pre10-2.bz2
kbuild25-3.0-for-2.4.19-pre10-ac2-2.bz2

Resynched with latest kbuild 2.5 core-18, which fixes some bugs.
Unfortunately, sourceforge version of kbuild*i386* still don't contain
s/CC/CC_real/ "fix" for Makefile.defs.*config. Mine contains.

and IKCONFIG option in -ac got reenabled now.

locations:
http://stingr.net/l/
ftp://stingr.net/pub/l/

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
