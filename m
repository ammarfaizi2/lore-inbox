Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264495AbSIQSoC>; Tue, 17 Sep 2002 14:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264498AbSIQSoC>; Tue, 17 Sep 2002 14:44:02 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50190 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264495AbSIQSoA>; Tue, 17 Sep 2002 14:44:00 -0400
Date: Tue, 17 Sep 2002 14:41:02 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS in 2.4.20-pre6+ stalls
In-Reply-To: <1032217821.2825.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020917144002.11859D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 2002, Alan Cox wrote:

> On Mon, 2002-09-16 at 23:54, Richard Gooch wrote:
> >   Hi, all. Just noticed this with 2.4.20-pre6 (and -pre7): NFS write
> > sometimes (usually) stalls for minutes at a time. This problem wasn't
> > there on 2.4.19. I've noticed this when writing a files around 1 MiB
> > or so (some a bit larger, some a bit smaller). It makes NFS almost
> > unusable. I've appended the kernel logs which come, at no extra
> 
> I've reported the same to Marcelo. Its there in a slightly different
> form in my case - low bandwidth streaming data shows it up very well.

This may explain why my favorite Internet radio station is acting up.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

