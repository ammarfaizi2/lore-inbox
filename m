Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317239AbSEXSmQ>; Fri, 24 May 2002 14:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317244AbSEXSmP>; Fri, 24 May 2002 14:42:15 -0400
Received: from p50886BFF.dip.t-dialin.net ([80.136.107.255]:57001 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317239AbSEXSmO>; Fri, 24 May 2002 14:42:14 -0400
Date: Fri, 24 May 2002 12:41:25 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>, Jan Kara <jack@suse.cz>,
        Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Quota patches
In-Reply-To: <E17BHha-0006m7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205241237580.15928-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 May 2002, Alan Cox wrote:
>       Add a CONFIG_SMALL where users can pick to have very small hash
> tables on older systems with little RAM.

On Fri, 24 May 2002, Alan Cox wrote:
> I'd been thinking about a set of options buried in a config menu item
> like "Fine tune configuration for small/embedded devices" CONFIG_SMALL

I'd prefer CONFIG_TIGHT_MEMORY. You never know what things in the world 
might be called small.

Regards,
Thunder
-- 
Was it a black who passed along in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.




