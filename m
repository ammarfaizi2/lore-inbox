Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293673AbSCADLp>; Thu, 28 Feb 2002 22:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310143AbSCADJ4>; Thu, 28 Feb 2002 22:09:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3091 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310328AbSCADJP>; Thu, 28 Feb 2002 22:09:15 -0500
Date: Thu, 28 Feb 2002 22:07:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Submissions for 2.4.19-pre [sdmany (Richard Gooch)] [Discuss :) ]
In-Reply-To: <E16gaRG-0001aR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020228220249.3310B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Alan Cox wrote:

> > Hate to say it but 2.5 is not ready for any kind of production use, and
> > some people really need to connect more SCSI devices than are currently
> > supported. That's NOT ivory tower, it's real world "do it with Linux"
> > problem solving.
> 
> I'd be interested to know if Al Viro considers devfs production use ready yet

I would say that is a fair question. I find it in the production kernel?
Good, so it was considered ready by someone. Seems to me one of the Redhat
kernels had devfs as a module, they seem to think so.

It's a good question, though, and I am assuming that the answer is "it's
in the stable kernel" which isn't yes or no.

If it's not stable then there simply is no Linux solution to large
storage. Given what vendors are doing I find that unintuitive.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

