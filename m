Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263668AbRFSFV4>; Tue, 19 Jun 2001 01:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263669AbRFSFVf>; Tue, 19 Jun 2001 01:21:35 -0400
Received: from www.wen-online.de ([212.223.88.39]:11270 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263668AbRFSFV0>;
	Tue, 19 Jun 2001 01:21:26 -0400
Date: Tue, 19 Jun 2001 07:20:46 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>,
        German Gomez Garcia <german@piraos.com>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <20010618154943.C13836@athlon.random>
Message-ID: <Pine.LNX.4.33.0106190719140.576-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Andrea Arcangeli wrote:

> On Mon, Jun 18, 2001 at 10:37:21AM -0300, Rik van Riel wrote:
> > Yes, this is expected behaviour with -ac14, -pre3 and newer.
>
> If that means anything that doesn't happen here based on pre3.

It doesn't happen here either.  Even with (ever so slightly modified)
fair background aging change.

	-Mike

