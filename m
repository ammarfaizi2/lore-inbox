Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLWUVd>; Sat, 23 Dec 2000 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQLWUVX>; Sat, 23 Dec 2000 15:21:23 -0500
Received: from tahallah.claranet.co.uk ([212.126.138.206]:28171 "EHLO
	tahallah.clara.co.uk") by vger.kernel.org with ESMTP
	id <S129410AbQLWUVG>; Sat, 23 Dec 2000 15:21:06 -0500
Date: Sat, 23 Dec 2000 19:50:36 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.clara.co.uk>
Reply-To: <alex.buell@tahallah.clara.co.uk>
To: Alex Buell <alex.buell@tahallah.clara.co.uk>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Netgear FA311 (follow-up)
In-Reply-To: <Pine.LNX.4.30.0012231607360.4359-100000@tahallah.clara.co.uk>
Message-ID: <Pine.LNX.4.30.0012231946530.4671-100000@tahallah.clara.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Alex Buell wrote:

> I recently bought a Netgear FA311 which does 10/100Mb/ethernet for my
> first home network. I've looked and found driver sources which
> apparently works only for 2.0.36. Ulp! Before I start cracking my
> knuckles and working my deep magic to get it to work on 2.2.x, is
> there any drivers already sorted for this card on the 2.2.x series?

Thanks to everyone who replied. I've now got Donald Becker's natsemi
drivers from his site and have successfully compiled it. Whether it'll
work is another story as I've got to crack this box and put in the card..

Won't be long before I'll have my 100 megabits home network up and
running, I hope. <big evil grin> Not long before I'll frag my kid brother
in Quake too!

Cheers,
Alex
-- 
I stand in my undergarments and hurl inventive in your general direction.

http://www.tahallah.clara.co.uk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
