Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSLVQpY>; Sun, 22 Dec 2002 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSLVQpY>; Sun, 22 Dec 2002 11:45:24 -0500
Received: from c3po.skynet.be ([195.238.3.237]:6593 "EHLO c3po.skynet.be")
	by vger.kernel.org with ESMTP id <S264972AbSLVQpX>;
	Sun, 22 Dec 2002 11:45:23 -0500
Message-Id: <200212221653.gBMGrT717778@c3po.skynet.be>
Date: Sun, 22 Dec 2002 17:53:28 +0100 (CET)
From: Helmut Jarausch <jarausch@skynet.be>
Reply-To: jarausch@skynet.be
Subject: Re: [2.4.21-p2] more VIA-IDE problems
To: linux-kernel@vger.kernel.org
cc: john@grabjohn.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote

> > beginning with 2.4.21-pre1 the kernel disables DMA on my
> > regular ATA harddrives.
> >

snip

>
> I think that they are superflous debugging messages, and that DMA is
>
> actually re-enabled silently afterwards. I could be wrong, though.

Probably you are right.

I've just run  bonnie++ (1.93) with 2.4.20 and 2.4.21-pre2
and there are NO significant differences.

Sorry for the noise!

Helmut.

-- 
Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
RWTH - Aachen University
D 52056 Aachen, Germany
