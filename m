Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271307AbRIFTwR>; Thu, 6 Sep 2001 15:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272534AbRIFTwH>; Thu, 6 Sep 2001 15:52:07 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:21378 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271307AbRIFTvv>; Thu, 6 Sep 2001 15:51:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: K7/Athlon optimizations and Sacrifices to the Great Ones.
Date: Thu, 6 Sep 2001 12:51:36 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090612513601.00171@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm upset, and angry, and could go into more detail but a future employer 
might read this.

133Mhz FSB + KT133A chipset theory has been officially shot to hell.
Not only that, but 6-4-4 (family/model/stepping) processors don't seem to 
be the culprit. I've now had reports of 6-4-2 experiencing problems, and 
6-4-4 NOT experiencing problems, even on KT133A @ 133Mhz.
At this point, I can't even isolate a MOTHERBOARD that could be the 
culprit, and I don't think it's the power supply.

The *only* other theory I have left in my arsenal is cooling. 
Unfortunately this data is more difficult to obtain from users, and thus 
wouldn't gather as many responses and in the end it'd probably be 
useless. It would be best tested in controlled conditions, but 
unfortunately I don't have the money to purchase the neccisary hardware 
to test these issues. Any companies want to sponsor tests? I'm serious, 
if someone wanted to, I'd be willing to test this possibility.
There is another remote possibility, and that's the fab plant that the 
processors came from. I didn't ask for CPU serial numbers, so I can't 
speak to that effect.
It's also possible that this is related to a specific batch or batches of 
KT133A chipsets, however I currently have one report of a guy seeing this 
problem on the SAME physical board, just two different processors. Both 
6-4-2, the only difference is that one is 1.13Ghz and doesn't have the 
problem, and the other is 1.2Ghz and DOES have the problem. This of 
course leads me back to the clock speed theory, but again it doesn't make 
any SENSE because the FSB on both of them is 133Mhz and I've got at least 
two reports of 1.33Ghz chips running FINE! ARG!
At this point, I'm giving up on collecting data, as I just don't see a 
definitive pattern, all I can say for sure is that the "majority" 
KT133A-based motherboards seem to have problems, but not ALL. I don't 
know of a single report outside of the KT133A chipset of these problems.

If anyone wants to keep collecting data, I'd be happy to send all the 
information I have so far to that person, and any that filters in over 
the next couple days.

Now for the Sacrifices.

At this point, I'd like to sacrifice a Red Hat Linux 6.2 CD to Alan Cox.

I would also like to sacrifice Minix 1.3(?) installation diskettes to 
Linus Torvalds.

I perform these sacrifices in the hope that enlightenment comes to me.
