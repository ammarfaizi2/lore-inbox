Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282198AbRKWSQZ>; Fri, 23 Nov 2001 13:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282199AbRKWSQQ>; Fri, 23 Nov 2001 13:16:16 -0500
Received: from xdsl-213-168-106-33.netcologne.de ([213.168.106.33]:19807 "EHLO
	ecce.homeip.net") by vger.kernel.org with ESMTP id <S282198AbRKWSQF>;
	Fri, 23 Nov 2001 13:16:05 -0500
Date: Fri, 23 Nov 2001 18:15:38 +0001 (UTC)
From: Thorsten Glaser <mirabilos@users.sourceforge.net>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <Pine.LNX.4.33.0111230953170.18098-100000@shell1.aracnet.com>
Message-ID: <Pine.BSO.4.42.0111231814190.16292-100000@ecce.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dixitur de M. Edward (Ed) Borasky respondebo ad:

> On Fri, 23 Nov 2001, [ISO-8859-1] Ra?l[ISO-8859-1] N??ez de Arenas  Coronado wrote:
>
> >     Sooner or later the kernel will need to be ported to gcc 3.x
> > series, so, the sooner it gets tested with this compiler, the better.
>
> One of the regression tests for gcc is to compile *a* Linux kernel, although
> I have no clue which kernel they use, or if they just haul down the latest one
> from the Internet.

It's one of the 2.2 series IIRC. Go http://gcc.gnu.org/

> >     Anyway, if you have gcc 2.95.x installed onto your distro, use
> > that for the kernel for maximum stability.

I've run 2.4.3-ac7 plus andrea's rwsem, compiled on a gcc-3 beta
of April 2001, since then (not in 24/7 though) with _no_ problems.

-mirabilos
-- 
| This message body is covered by Germanic and International | OpenBSD30
| Copyright law. Modification of any kind and redistribution | centericq
| via AOL or the Microsoft network are strictly prohibited!! | UIN seems
| Scientific-style quotation permitted if due credits given. | 132315236

