Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRCHUXI>; Thu, 8 Mar 2001 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRCHUWx>; Thu, 8 Mar 2001 15:22:53 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:28678 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S129511AbRCHUVO>; Thu, 8 Mar 2001 15:21:14 -0500
Date: Thu, 8 Mar 2001 21:19:57 +0100 (CET)
From: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Oswald Buddenhagen <ob6@inf.tu-dresden.de>, linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <Pine.LNX.4.33.0103081043550.1409-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.20.0103082118510.4425-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Of course. Now we just need the code to determine when a task
> is holding some kernel-side lock  ;)

couldn't it just be indicated on actual locking the resource?

lynx


