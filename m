Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137046AbREKFQt>; Fri, 11 May 2001 01:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137047AbREKFQj>; Fri, 11 May 2001 01:16:39 -0400
Received: from web10206.mail.yahoo.com ([216.136.130.70]:6919 "HELO
	web10206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S137046AbREKFQY>; Fri, 11 May 2001 01:16:24 -0400
Message-ID: <20010511051623.69540.qmail@web10206.mail.yahoo.com>
Date: Thu, 10 May 2001 22:16:23 -0700 (PDT)
From: sri gg <srimg@yahoo.com>
Subject: usb uhci & 8139too ON 2.4.2
To: linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      I recently compiled the 2.4.2 with usb support.
I also brought a ethernet card based on the 8139too.o
driver. When i insert the module, the following 
message keeps blurting out:

kernel: uhci: host controller halted. very bad
kernel: uhci: host controller halted. very bad
kernel: uhci: host controller halted. very bad
.
.
.

this happens only when i insert the 8139too module.
else the usb works fine, and detects the usb
devices. Is there anything i am missing or should be
doing... Any help or suggestions would be very 
helpful.
Thanks.
srimg.

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
