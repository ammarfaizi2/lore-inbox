Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDPbX>; Sat, 4 Nov 2000 10:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129128AbQKDPbM>; Sat, 4 Nov 2000 10:31:12 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45583 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129057AbQKDPa7>;
	Sat, 4 Nov 2000 10:30:59 -0500
Message-ID: <3A042B87.9AD362A9@mandrakesoft.com>
Date: Sat, 04 Nov 2000 10:30:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Dunlap Randy <randy.dunlap@intel.com>,
        "'David Woodhouse'" <dwmw2@infradead.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: USB init order dependencies.
In-Reply-To: <200011041438.OAA05656@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> There'll be quite a few extra init calls going in there then, with lots
> and lots of ifdefs ;(

I was talking about one or two init/main.c additions.  If you know of
"quite a few" link order problems outside of main USB subsystem init,
speak up...

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
