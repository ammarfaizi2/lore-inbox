Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbQLMBNy>; Tue, 12 Dec 2000 20:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbQLMBNo>; Tue, 12 Dec 2000 20:13:44 -0500
Received: from [63.109.146.2] ([63.109.146.2]:32761 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S129956AbQLMBNc>;
	Tue, 12 Dec 2000 20:13:32 -0500
Message-ID: <4461B4112BDB2A4FB5635DE19958743202239C@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: linux-kernel@vger.kernel.org
Cc: "'adam@yggdrasil.com'" <adam@yggdrasil.com>,
        "'thockin@isunix.it.ilstu.edu'" <thockin@isunix.it.ilstu.edu>
Subject: National Semiconductor DP83815 ethernet driver?
Date: Tue, 12 Dec 2000 16:42:56 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am wondering about the current status of a driver for the NS83815 ethernet
chip.

>From searching Google, I know some sort of driver exists. In July, Adam J.
Richter (adam@yggdrasil.com) posted a 2.2.16 driver he obtained from Dave
Gotwisner at Wyse Technologies. And Tim Hockin mentioned that he was using
an NSC driver, but had made some minor modifications.

The only source I've seen is the one Mr. Richter posted.
(http://web.gnu.walfield.org/mail-archive/linux-kernel/2000-July/4234.html).

How well does this driver work?  From Mr. Richter's email I gather that Alan
Cox gave some feedback and suggested improvements.  This makes me worried
about using the "unimproved" version of the driver.

If anyone has improved code for the 2.2.x series I would greatly appreciate
it.

2.2.17 and 18 didn't include the driver. I also gather that Mr. Richter is
(or was) concentrating on a port to the 2.4 series, how is that coming
along? 

For what it's worth, the chip seems to have detailed documentation at
http://www.national.com/pf/DP/DP83815.html.

Thanks for any help.  

Torrey Hoffman
torrey.hoffman@myrio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
