Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269070AbTBXCFT>; Sun, 23 Feb 2003 21:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269074AbTBXCFT>; Sun, 23 Feb 2003 21:05:19 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:26066 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S269070AbTBXCFS>; Sun, 23 Feb 2003 21:05:18 -0500
Date: Sun, 23 Feb 2003 18:15:29 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: davidm@hpl.hp.com
cc: David Lang <david.lang@digitalinsight.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <15961.31702.478219.82652@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.53.0302231806180.23231@twinlark.arctic.org>
References: <15961.19948.882374.766245@napali.hpl.hp.com>
 <Pine.LNX.4.44.0302231444490.8609-100000@dlang.diginsite.com>
 <15961.20756.474745.44896@napali.hpl.hp.com> <Pine.LNX.4.53.0302231704310.23231@twinlark.arctic.org>
 <15961.31702.478219.82652@napali.hpl.hp.com>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Feb 2003, David Mosberger wrote:

> >>>>> On Sun, 23 Feb 2003 17:06:29 -0800 (PST), dean gaudet <dean-list-linux-kernel@arctic.org> said:
>
>   Dean> On Sun, 23 Feb 2003, David Mosberger wrote:
>   >> >>>>> On Sun, 23 Feb 2003 14:48:48 -0800 (PST), David Lang <david.lang@digitalinsight.com> said:
>
>   David.L> I would call a 15% lead over the ia64 pretty substantial.
>
>   >> Huh?  Did you misread my mail?
>
>   >> 2 GHz Xeon:		701 SPECint
>   >> 1 GHz Itanium 2:	810 SPECint
>
>   >> That is, Itanium 2 is 15% faster.
>
>   Dean> according to pricewatch i could buy ten 2GHz Xeons for about
>   Dean> the cost of one Itanium 2 900MHz.
>
> Not if you want comparable cache-sizes [1]:

somehow i doubt you're quoting Xeon numbers w/2MB of cache above.  in
fact, here's a 701 specint with only 512KB of cache @ 2GHz:

http://www.spec.org/osg/cpu2000/results/res2002q1/cpu2000-20020128-01232.html

my point was that if you had comparable die sizes the 15% "advantage"
would disappear.  there's a hell of a lot which could be done with the
approximately double die size that the itanium 2 has compared to any of
the commodity x86 parts.  but then the cost per part would be
correspondingly higher... which is exactly what is shown in the intel cost
numbers.

a more fair comparison would be your itanium 2 number with this:

http://www.spec.org/osg/cpu2000/results/res2002q4/cpu2000-20021021-01742.html

2MB L2 Xeon @ 2GHz, scores 842.

is this the itanium 2 number you're quoting us?

http://www.spec.org/osg/cpu2000/results/res2002q3/cpu2000-20020711-01469.html

'cause that's with 3MB L3.

-dean

>
>  Intel Xeon MP, 2MB L3 cache:		$3692
>
>  Itanium 2, 1 GHZ, 3MB L3 cache:	$4226
>  Itanium 2, 1 GHZ, 1.5MB L3 cache:	$2247
>  Itanium 2, 900 MHZ, 1.5MB L3 cache:	$1338
>
> Intel basically prices things by the cache size.
>
> 	--david
>
> [1]: http://www.intel.com/intel/finance/pricelist/
>
