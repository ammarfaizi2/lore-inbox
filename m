Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSGYVt4>; Thu, 25 Jul 2002 17:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSGYVt4>; Thu, 25 Jul 2002 17:49:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45316 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316569AbSGYVtz>; Thu, 25 Jul 2002 17:49:55 -0400
Date: Thu, 25 Jul 2002 23:53:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix complile warnings in suspend.c, 2.5.28
Message-ID: <20020725215312.GA489@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0207250536451.17973-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207250536451.17973-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This fixes some compile time warnings in suspend.c.  Look sensible? 
> It's tested, even with full rmap and slab-on-LRU patches.  Even worked 
> when suspending from X!

Does it work for you? I get reboot after S4 on 2.5.28. Can you mail me
diff between clean and your tree?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
