Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSHDMtW>; Sun, 4 Aug 2002 08:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSHDMtW>; Sun, 4 Aug 2002 08:49:22 -0400
Received: from stingr.net ([212.193.32.15]:37530 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S316659AbSHDMtS>;
	Sun, 4 Aug 2002 08:49:18 -0400
Date: Sun, 4 Aug 2002 16:52:51 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 make allmodconfig - undefined symbols
Message-ID: <20020804125251.GB13637@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <29906.1028456000@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <29906.1028456000@ocs3.intra.ocs.com.au>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Keith Owens:
> 2.4.19 make allmodconfig.  Besides the perennial drivers/net/wan/comx.o
> wanting proc_get_inode, there was only one undefined symbol.  In the
> extremely unlikely event that binfmt_elf is a module (how do you load
> modules when binfmt_elf is a module?), smp_num_siblings is unresolved.

I wrote about it many times at 19-pre stage. With patches, err, to warning
cases too. _Nothing_ is applied.

They still in my tree ... but who interested in my tree ? :)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
