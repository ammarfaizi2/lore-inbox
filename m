Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAKSOo>; Thu, 11 Jan 2001 13:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbRAKSOf>; Thu, 11 Jan 2001 13:14:35 -0500
Received: from colorfullife.com ([216.156.138.34]:25363 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129868AbRAKSOR>;
	Thu, 11 Jan 2001 13:14:17 -0500
Message-ID: <3A5DF829.C4DD6F27@colorfullife.com>
Date: Thu, 11 Jan 2001 19:15:05 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Apology for duplicates (was Re: Compatibility issue with 2.2.19pre7 
 (fwd))
In-Reply-To: <Pine.LNX.4.10.10101111253010.20677-110000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> hi.  I've received 8 copiies of this message (via linux-kernel) so far.
> headers indicate that the following hop is being repeated:
> 
8. That's weird - according to my maillogs colorfullife.com (my own
server) only sent 6 copies to everyone.
The attached one is the 5. messages, so probably one more will come.

I have no idea what caused the duplication, probably I misconfigured
something with smarthost.

clsrvli: internal server, smarthost to colorfullife.com
colorfullife.com: real server, sends messages to the rest of the world.

The message had 6 receivers, and one of them was unreachable for 50
minutes. It seems the sendmail resend the message to all receivers,
although the first 5 were successful.

One retry every 10 minutes --> 6 duplicates

Sorry,
	Manfred Spraul
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
