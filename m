Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUJPRW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUJPRW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUJPRW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:22:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268166AbUJPRWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:22:25 -0400
Date: Sat, 16 Oct 2004 19:21:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Erwin Schoenmakers <esc-solutions@planet.nl>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)
Message-ID: <20041016172154.GH5307@stusta.de>
References: <417139A2.5090705@planet.nl> <20041016191704.A20686@jurassic.park.msu.ru> <20041016153017.GE5307@stusta.de> <20041016195847.A20976@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016195847.A20976@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:58:47PM +0400, Ivan Kokshaysky wrote:
> On Sat, Oct 16, 2004 at 05:30:17PM +0200, Adrian Bunk wrote:
> > What are the required versions on Alpha?
> 
> IIRC, gcc >= 3.3.4, binutils >= 2.13.

The gcc dependency sounds pretty tough.

Why isn't even gcc 3.3.3 able to produce a kernel on Alpha?

> > According to Documentation/Changes, Erwin's versions were OK.
> 
> Probably it needs to be updated. I doubt if these versions
> work on x86_64 at all, for example.

That's the smaller problem. Since you can't build a gcc 2.95 for amd64 
noone can try using it for building the kernel...

> Ivan.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

