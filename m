Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbRBBRS7>; Fri, 2 Feb 2001 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRBBRSt>; Fri, 2 Feb 2001 12:18:49 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:61579 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S129367AbRBBRSn>; Fri, 2 Feb 2001 12:18:43 -0500
Date: Fri, 2 Feb 2001 18:18:38 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: infernix <infernix@infernix.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: isdn_ppp.c bug (isdn_lzscomp.c aka STAC compression > oops on
 2.4.x)
In-Reply-To: <019701c08d2b$2fc78950$960aa8c0@infernix>
Message-ID: <Pine.LNX.4.10.10102021816460.15155-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, infernix wrote:

> However, the patch hasn't been implemented yet, neither in 2.4.1 or in
> 2.4.1-ac1, because the obvious "HACK,HACK,HACK" sentence is still present :)
> Could someone see to it that this mail reaches the kernel's isdn_ppp.c
> maintainer and get this thing moving? Thanks.

Look again. The patch you quoted is in patch-2.4.1.bz2. Don't know about
2.4.1-ac1. (But I doubt it's reverted there :)

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
