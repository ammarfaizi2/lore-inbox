Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267822AbRGWGwh>; Mon, 23 Jul 2001 02:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268134AbRGWGw1>; Mon, 23 Jul 2001 02:52:27 -0400
Received: from web13901.mail.yahoo.com ([216.136.175.27]:34575 "HELO
	web13901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267822AbRGWGwI>; Mon, 23 Jul 2001 02:52:08 -0400
Message-ID: <20010723065212.31153.qmail@web13901.mail.yahoo.com>
Date: Sun, 22 Jul 2001 23:52:12 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about serial console problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, all,

I am porting linux 2.4.3 to our mipsel evaluation
board. Now I meet a problem. Because I use edown
to download the linux kernel to evaluation board.
I update the serial baud rate to 115200.
I use serial 0 as our console, and I can use
printk to print debug messages on serial port.
But after kernel call /sbin/init, I can not
see "INIT ...  ..." messages on serial port.
I suppose perhaps I make some mistakes. But when
I use 2.2.12 kernel, it ok.
If someone knows, please help me. Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
