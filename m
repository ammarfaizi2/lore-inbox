Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRA3QEx>; Tue, 30 Jan 2001 11:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbRA3QEo>; Tue, 30 Jan 2001 11:04:44 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:36874 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131172AbRA3QEZ>;
	Tue, 30 Jan 2001 11:04:25 -0500
Date: Tue, 30 Jan 2001 17:03:48 +0100
From: Frank de Lange <frank@unternet.org>
To: heikki@indexdata.dk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Mailing List, Archive by Week: Gigabyte 6VXDC7: APGigabyte 6VXDC7: APIC error on CPU1: 08(08)
Message-ID: <20010130170348.I14319@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki,

Those are the same problems I had with my Abit BP-6 SMP-board. There are a
couple of patched which seem to make the problem disappear. The jury is still
not out on whether they really solve the problem or merely hide it, but I
haven't had a crash ever since I patched my box. The most recent patch is the
one from Maciej, you can find it on the list, or in the archives (like this
one: http://boudicca.tux.org/hypermail/linux-kernel/this-week/0469.html - this
link is only valid 'till sunday!)

Unfortunately, the archives often mangle patches, so it is better to get them
directly from the list (or mail Maciej for it...)

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
