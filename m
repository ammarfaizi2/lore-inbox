Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUDBLod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 06:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDBLod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 06:44:33 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:4363 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S262542AbUDBLoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 06:44:32 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1080906194@astro.swin.edu.au>
Subject: Re:  [PATCH] cowlinks v2
In-reply-to: <20040331144536.GA328@elf.ucw.cz>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040331143412.GA18990@mail.shareable.org> <20040331144536.GA328@elf.ucw.cz>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-30567-17303-200404022143-tc@hexane.ssi.swin.edu.au>
Date: Fri, 2 Apr 2004 21:44:28 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> said on Wed, 31 Mar 2004 16:45:37 +0200:
> Hi!
> > The garbage collection is what's horrible about it :)
> > Btw, 15 would be exceeded easily in my home directory.
> 
> Well, but chances are that you'll never unlink such files... Leaving
> garbage collection to fsck would make it rather easy.

How often do you fsck? Sure, I fscked the other day, but that's
because some idiot unplugged my laptop.

I sure as hell delete copied trees more often than once every 6 months
though :)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
I'm sorry. The number you have reached is imaginary. Please rotate your
phone 90 degrees and try again.
