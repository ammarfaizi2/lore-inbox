Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269015AbRHGG5o>; Tue, 7 Aug 2001 02:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268919AbRHGG5e>; Tue, 7 Aug 2001 02:57:34 -0400
Received: from imladris.infradead.org ([194.205.184.45]:52753 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269015AbRHGG5X>;
	Tue, 7 Aug 2001 02:57:23 -0400
Date: Tue, 7 Aug 2001 07:57:04 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3c509: broken(verified)
In-Reply-To: <E15Tvju-0001ta-00@infradead.org>
Message-ID: <Pine.LNX.4.33.0108070747400.11557-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dieter.

 >>>> You mention the problem is being unable to change the media, I
 >>>> was unaware this was even possible with the current 3c509
 >>>> driver, and most people do it on 3c509's and other PNP cards of
 >>>> this sort (such as NE2000 clones)  by using a DOS boot diskette
 >>>> and the DOS utilities provided by the manufacturer.

 >>> That's what I did. I've set it to "auto mode" and it works with
 >>> RJ45 cable. But I can't verify if "full duplex" worked right.

 >> What transfer speed do you get doing an FTP transfer across the
 >> link?

 > Don't know. I have to plug a laptop or something on it to test.
 > Perhaps Dad's PC (but the latter is still connected via switched
 > 100 Mbits ;-)

Nodz...

 >> 10base is theoretically capable of one meg per second,

 > 1.25 MByte/sec (max)

Given perfectly accurate clocks at both ends, yes, but when is that
achieved?

 >> and experience indicates that a 10baseT link normally shows just
 >> under 500k per second flat out, presumably due to the half
 >> duplex nature of the 10baseT protocol. I'd expect 10base2 half
 >> duplex to be similar, and 10base2 full duplex to be somewhat
 >> faster.

 > I thought it should read 10baseT (with RJ45 cable) can reach
 > 1.25 MByte/sec full duplex (switched)?

The choice of base2 or baseT decides the cable used - see below.

 >>> So I changed it under Win to "10baseT" for which the 3Com
 >>> utilities say "full duplex" enabled.

 >> One slight problem - 10baseT uses CoAxial cable, not RJ45 - and,
 >> as far as I'm aware, 10baseT is strictly half duplex whereas
 >> 10base2 (which uses RJ45 twisted pair cable) is capable of
 >> either half or full duplex.

 > See above.

See my reply to Mark Hahn a few minutes ago for a fuller discussion.

Best wishes from Riley.


