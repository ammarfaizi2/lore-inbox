Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbQLWSZV>; Sat, 23 Dec 2000 13:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbQLWSZL>; Sat, 23 Dec 2000 13:25:11 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:26603 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129855AbQLWSZE>; Sat, 23 Dec 2000 13:25:04 -0500
Message-ID: <3A44E6CE.6C1529BB@haque.net>
Date: Sat, 23 Dec 2000 12:54:22 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alex.buell@tahallah.clara.co.uk
CC: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Netgear FA311
In-Reply-To: <Pine.LNX.4.30.0012231607360.4359-100000@tahallah.clara.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know how its different from the FA310TX that I have. The 310TX
uses the tulip drivers so you may want to give that a shot.

Maybe you can get us a name/number off the IC on the card?

Alex Buell wrote:
> 
> I recently bought a Netgear FA311 which does 10/100Mb/ethernet for my
> first home network. I've looked and found driver sources which apparently
> works only for 2.0.36. Ulp! Before I start cracking my knuckles and
> working my deep magic to get it to work on 2.2.x, is there any drivers
> already sorted for this card on the 2.2.x series?
> 
> If not, where can I find documentation on converting 2.0.x drivers to
> 2.2.x?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
