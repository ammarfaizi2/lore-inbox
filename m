Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRCHU4I>; Thu, 8 Mar 2001 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCHUz6>; Thu, 8 Mar 2001 15:55:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53464 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129609AbRCHUzn>;
	Thu, 8 Mar 2001 15:55:43 -0500
Date: Thu, 8 Mar 2001 17:47:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
cc: Oswald Buddenhagen <ob6@inf.tu-dresden.de>, <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <Pine.LNX.4.20.0103082118510.4425-100000@falcon.etf.bg.ac.yu>
Message-ID: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Boris Dragovic wrote:

> > Of course. Now we just need the code to determine when a task
> > is holding some kernel-side lock  ;)
>
> couldn't it just be indicated on actual locking the resource?

It could, but I doubt we would want this overhead on the locking...

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

