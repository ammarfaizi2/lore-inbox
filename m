Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSEaD5I>; Thu, 30 May 2002 23:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSEaD5H>; Thu, 30 May 2002 23:57:07 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:48536 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S314690AbSEaD5G>; Thu, 30 May 2002 23:57:06 -0400
Date: Fri, 31 May 2002 00:01:27 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Mail-Followup-To: Thunder from the hill <thunder@ngforever.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020531011600.ENOZ28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net> <Pine.LNX.4.44.0205302129120.29405-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020531035702.EOBK28280.pop018.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> On Thu, 30 May 2002, Skip Ford wrote:
> > I could be wrong but I think Linus wants small patches that slowly
> > convert kbuild24 to kbuild25, and not just a chopped up wholesale
> > kbuild25.
> 
> That's what we have. If you want to try kbuild-2.5, you have to use the
> Makefile-2.5 explicitly. If you don't explicitly do that, you're using 
> kbuild-2.4, so you got a pretty good chance to evaluate kbuild-2.5 and 
> then decide whether you leave it or pull it. Enough migration?

That's not a migration at all.  That's two different build systems side
by side.

A migration would mean that there is only ever 1 build system.  Send
patches that would convert what we have now to kbuild25 over the next 10
kernel releases or so.  That's a migration.

-- 
Skip
