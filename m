Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276647AbRJUTjI>; Sun, 21 Oct 2001 15:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276651AbRJUTis>; Sun, 21 Oct 2001 15:38:48 -0400
Received: from shake.vivendi.hu ([213.163.0.180]:18306 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S276647AbRJUTij>; Sun, 21 Oct 2001 15:38:39 -0400
Date: Sun, 21 Oct 2001 21:39:06 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Federico Sevilla III <jijo@leathercollection.ph>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 vs. ext3?
Message-ID: <20011021213906.B19390@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEKODPAA.znmeb@aracnet.com> <Pine.LNX.4.40.0110220306280.21933-100000@gusi.leathercollection.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0110220306280.21933-100000@gusi.leathercollection.ph>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 03:13:38AM +0800, Federico Sevilla III wrote:
> Basically ext3 builds on ext2 to add journalling support, which means
> significantly less (almost nil) fsck time in the eventuality of an unclean
> powerdown.

By the way ... And what's about index usage in ext2(ext3) directories?
Some months ago there was a benchmark sheet publicated in this list and
it shown major performance win on handling large directories. Is it considered
to include into ext2/ext3 implementation in Linus or Alan Cox series of kernels?
Or probably did I miss something?
 
> For now XFS and JFS provide patches to allow you to get working kernel
> support for them. I personally use XFS and have found that it is very
> stable, as have a lot of other fellow XFS users. I'm not saying it's the
> absolute best. But I'm saying it's great, and is fairly stable. :)

Yes, our country-wide proxy server is XFS/Linux based.

- Gabor
