Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQKJRUp>; Fri, 10 Nov 2000 12:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQKJRUe>; Fri, 10 Nov 2000 12:20:34 -0500
Received: from gw.ahoj.pl ([212.45.230.114]:1805 "EHLO tfuj.ahoj.pl")
	by vger.kernel.org with ESMTP id <S130696AbQKJRUd>;
	Fri, 10 Nov 2000 12:20:33 -0500
Date: Fri, 10 Nov 2000 18:17:31 +0100 (CET)
From: Pawe³ Kot <pkot@linuxnews.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test11pre2-ac1 and previous problem
Message-ID: <Pine.LNX.4.30.0011101806140.29502-100000@tfuj.ahoj.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've following error with 2.4.0-test{9|10|pre11pre1-ac1|pre11pre2-ac1}:

NMI Watchdog detected LOCKUP on CPU3, registers:

And then the machine hangs. No response at all.
Always CPU3 is mentioned.
The machine is:
The latest Intel motherboard for 4xCPU (ISP4040)
4xPentium III 700 (Xeon)
4GB RAM
mylex raid array (the newest controller)
eepro100 ethernet card

This machine is running only MySQL database.

What can be wrong?

pkot
-- 
mailto:pkot@linuxnews.pl
http://urtica.linuxnews.pl/~pkot/
http://newsreader.linuxnews.pl/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
