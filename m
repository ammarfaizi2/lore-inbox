Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285569AbRLNWwu>; Fri, 14 Dec 2001 17:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285572AbRLNWwl>; Fri, 14 Dec 2001 17:52:41 -0500
Received: from www.wen-online.de ([212.223.88.39]:22532 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S285568AbRLNWwa>;
	Fri, 14 Dec 2001 17:52:30 -0500
Date: Fri, 14 Dec 2001 23:54:57 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Leigh Orf <orf@mailbag.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Ken Brownfield <brownfld@irridia.com>,
        "M.H.VanLeeuwen" <vanl@megsinet.net>,
        Mark Hahn <hahn@physics.mcmaster.ca>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 memory badness (fixed?) 
In-Reply-To: <200112101549.fBAFnOq08395@orp.orf.cx>
Message-ID: <Pine.LNX.4.33.0112142336290.470-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Leigh Orf wrote:

> And in fact, after furthur playing around with the "fixed" version
> (moving shrink_[id]cache_memory to the top of vmscan.c::shrink_caches)
> I find that I still will get ENOMEM after updatedb occasionally. Less
> often than before, but it still happens.

Yes.. reasonable.

	-Mike

