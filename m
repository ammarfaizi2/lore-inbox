Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129803AbRBKSGp>; Sun, 11 Feb 2001 13:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbRBKSGf>; Sun, 11 Feb 2001 13:06:35 -0500
Received: from Guard.PolyNet.Lviv.UA ([217.9.2.1]:51729 "HELO
	guard.polynet.lviv.ua") by vger.kernel.org with SMTP
	id <S129746AbRBKSGU>; Sun, 11 Feb 2001 13:06:20 -0500
Date: 11 Feb 2001 20:01:48 +0200
Message-ID: <14711049588.20010211200148@polynet.lviv.ua>
From: "Andriy Korud" <akorud@polynet.lviv.ua>
Reply-To: "Andriy Korud" <akorud@polynet.lviv.ua>
To: linux-kernel@vger.kernel.org
X-Mailer: The Bat! (v1.49)
X-Priority: 3 (Normal)
Subject: Re[2]: Where are you going with 2.4.x?
In-Reply-To: <E14S07t-0004Ty-00@the-village.bc.nu>
In-Reply-To: <E14S07t-0004Ty-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan> What is the oops data before the kernel panic. I need that to debug the
Alan> driver. Also did you build the DAC960 support with gcc 2.96-x x<74 ?
My system compiler is:
   gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
Shoud I upgrade it to gcc 2.95.x or 2.96.x?

And since my last post 2.4.1-ac8 crashed again with:
    kswapd: Cannot dereference NULL pointer.

On the next crash I'll try write down all traces.
BTW, is there some way to log it somewhere to file?

-- 
Best regards,
 Andriy                            mailto:akorud@polynet.lviv.ua


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
