Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285573AbRLGVwn>; Fri, 7 Dec 2001 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285575AbRLGVwf>; Fri, 7 Dec 2001 16:52:35 -0500
Received: from www.wen-online.de ([212.223.88.39]:40972 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S285573AbRLGVwX>;
	Fri, 7 Dec 2001 16:52:23 -0500
Date: Fri, 7 Dec 2001 22:53:56 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Pablo Borges <pablo.borges@uol.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <E16CGbQ-00051W-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112072209520.989-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Alan Cox wrote:

> > In Rik's VM I had a problem with use-once when Bonnie was doing
> > rewrite.  It's used-twice data became too hard to get rid of at
>
> You are not supposed to use Riel's VM with use-once. The two were never
> intended to be combined.

I like the idea behind use-once very much, but given the side-effects
seen here.... I'm not sure.

	-Mike

