Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276215AbRJCNTi>; Wed, 3 Oct 2001 09:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276211AbRJCNTS>; Wed, 3 Oct 2001 09:19:18 -0400
Received: from traal.softpixel.com ([65.203.88.42]:10248 "HELO softpixel.com")
	by vger.kernel.org with SMTP id <S276208AbRJCNTR>;
	Wed, 3 Oct 2001 09:19:17 -0400
Message-ID: <30402.205.188.199.21.1002115377@webmail.softpixel.com>
Date: Wed, 3 Oct 2001 09:22:57 -0400 (EDT)
Subject: Re: kswapd kernel 2.4.9
From: <cwright@softpixel.com>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 0.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I\'m running kernel 2.4.9 under a DELL 8450 with 8xP-III  and 10GB RAM. 
> Yesterday a run a BIG   I/O, and when this process run, my cached goes to 
9GB 
> and the kswapd is using 100% of one cpu after that.

did it stay at 100%, or did it ease up slightly afterward?

I have noticed a similar problem with ancient kernels (2.0.0) and not quite 
as ancient one (2.2.19) where certain applications cause all your physical 
ram to be used, then all the cache.  after its all used (for some mystery 
purpose?) it goes back to normal.  maybe my boxes are just flukes though

        chris

