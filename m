Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSLUKmO>; Sat, 21 Dec 2002 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLUKmO>; Sat, 21 Dec 2002 05:42:14 -0500
Received: from smtp-03.inode.at ([62.99.194.5]:4066 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S266868AbSLUKmM> convert rfc822-to-8bit;
	Sat, 21 Dec 2002 05:42:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: vt8235 fix, hopefully last variant
Date: Sat, 21 Dec 2002 11:51:50 +0100
User-Agent: KMail/1.4.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, John Reiser <jreiser@BitWagon.com>,
       AnonimoVeneziano <voloterreno@tin.it>,
       Roland Quast <rquast@hotshed.com>, linux-kernel@vger.kernel.org
References: <20021219112640.A21164@ucw.cz> <200212202112.58475.black666@inode.at> <20021221102100.B29004@ucw.cz>
In-Reply-To: <20021221102100.B29004@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212211151.50991.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik:

> > starbase:/usr/src/linux-2.4.20# patch -p1 < vt8235-atapi
> > patching file drivers/ide/via82cxxx.c
> > Hunk #1 FAILED at 1.
> > Hunk #2 FAILED at 141.
> > Hunk #3 succeeded at 283 (offset -57 lines).
> > 2 out of 3 hunks FAILED -- saving rejects to file
> > starbase:/usr/src/linux-2.4.20#
>
> Since they're in comments only, you can ignore them.
>
> Can you please try even when the first two hunks failed? Only the
> third one really matters.

I patched the clean 2.4.20 source and it boots just fine after 
compiling. DMA works fine too.
It's now my default kernel so I'll test it a bit more....

MSI KT3Ultra2, TOSHIBA DVD-ROM SD-M1302

Thanks,
Patrick




