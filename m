Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbSKSR7b>; Tue, 19 Nov 2002 12:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSKSR7b>; Tue, 19 Nov 2002 12:59:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266995AbSKSR7b>; Tue, 19 Nov 2002 12:59:31 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PANIC]: 2.5.4x -> .48: Radeon driver sync problem
Date: Tue, 19 Nov 2002 18:06:22 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <arduiu$1ru$1@penguin.transmeta.com>
References: <200211190044.01726.spstarr@sh0n.net>
X-Trace: palladium.transmeta.com 1037729179 5638 127.0.0.1 (19 Nov 2002 18:06:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 19 Nov 2002 18:06:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200211190044.01726.spstarr@sh0n.net>,
Shawn Starr  <spstarr@sh0n.net> wrote:
>
>Can't use ksymoops (busted compile with binutils 2.13.90.0.10 20021010 and  
>GCC 3.2.1 20021118 (prerelease))
>
>Can't use kksymoops as its commented out in Kconfig (i386 arch) ;-) and it 
>doesnt seem to work uncommented ;(

Can you try current BK or the latest nightly snapshot? It should be
fixed there.. (knock wood).

		Linus
