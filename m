Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289273AbSAGQgA>; Mon, 7 Jan 2002 11:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289253AbSAGQfu>; Mon, 7 Jan 2002 11:35:50 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:50959 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289262AbSAGQfl>;
	Mon, 7 Jan 2002 11:35:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
Date: Mon, 7 Jan 2002 17:38:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: cej@ti.com (christian e), riel@conectiva.com.br (Rik van Riel),
        andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <E16NcHz-0001dv-00@the-village.bc.nu>
In-Reply-To: <E16NcHz-0001dv-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NcnC-0001RM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 05:06 pm, Alan Cox wrote:
> > knobs. It just won't happen. Fixing VM behavior is the only way. It has 
> > to work satisfactorily _without_ tuning.
> 
> Thats something you will never achieve. Virtual memory is about heuristics,
> crystal ball gazing and guesswork. There are always some workloads where you
> want little caching and some where you want lots of caching - such as a 
> fileserver.

You can get close though.  The fact that we aren't close is no proof of 
impossibility.  If we do give up and decide to ship only 'manual 
transmissions', we can be quite sure we'll never get there.

> You can make it right for most people but the last few percent you
> will always get by tuning knobs - either directly or via GUI tools like
> powertweak

Except, as you and others have pointed out, we are far from knowing what the 
knobs should be.

--
Daniel
