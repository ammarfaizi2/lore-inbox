Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289251AbSAGQNa>; Mon, 7 Jan 2002 11:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289248AbSAGQNU>; Mon, 7 Jan 2002 11:13:20 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:61199 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S289250AbSAGQND>; Mon, 7 Jan 2002 11:13:03 -0500
Date: Mon, 7 Jan 2002 08:13:10 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade
 performance still suck :-(
In-Reply-To: <E16NcHz-0001dv-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201070808340.13875-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Alan Cox wrote:

> > knobs. It just won't happen. Fixing VM behavior is the only way. It has to
> > work satisfactorily _without_ tuning.
>
> Thats something you will never achieve. Virtual memory is about heuristics,
> crystal ball gazing and guesswork. There are always some workloads where you
> want little caching and some where you want lots of caching - such as a
> fileserver.
>
> You can make it right for most people but the last few percent you
> will always get by tuning knobs - either directly or via GUI tools like
> powertweak

Thank you, Alan!! Now if the *other* kernel developers would just buy
into this. :)

-- 
M. Edward "Give me tuning knobs or give me death" Borasky

znmeb@borasky-research.net
http://www.borasky-research.net "The Few! The Proud! The Tweakers!"

The American people are tired of being told what the American people
are tired of.

