Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281009AbRKKIfV>; Sun, 11 Nov 2001 03:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281019AbRKKIfL>; Sun, 11 Nov 2001 03:35:11 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:56778 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281009AbRKKIe7>; Sun, 11 Nov 2001 03:34:59 -0500
Date: Sun, 11 Nov 2001 09:34:42 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: linux-kernel@vger.kernel.org
Subject: Re: Numbers: ext2/ext3/reiser Performance (ext3 is slow)
In-Reply-To: <E162nwk-0005iG-00@schizo.psychosis.com>
Message-ID: <Pine.LNX.4.40.0111110913160.21659-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.27)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Saturday 10 November 2001 9:29, Oktay Akbal wrote:
>
> > Time to complete sql-bench
> >
> > ext2	176min
> > reiser  203min (+15%)
> > ext3    310min (+76%)   (first test with 2.4.14-ext3 319min)

For completeness:

ext3 (writeback) 204min (as predicted Arjan now on the reiser level)
ext3 (journal)   386min (+119%)

>From the explanation in the ext3-Documentation, I did not realize,
that the difference could be that big.

Thanks

Oktay Akbal




