Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbQJ2VOz>; Sun, 29 Oct 2000 16:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbQJ2VOp>; Sun, 29 Oct 2000 16:14:45 -0500
Received: from web6105.mail.yahoo.com ([128.11.22.99]:12550 "HELO
	web6105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129331AbQJ2VOk>; Sun, 29 Oct 2000 16:14:40 -0500
Message-ID: <20001029211439.25286.qmail@web6105.mail.yahoo.com>
Date: Sun, 29 Oct 2000 13:14:39 -0800 (PST)
From: Hunt Kent <kenthunt@yahoo.com>
Subject: Re:[patch] 2.4.0-test10-pre6 fix usb initialization order
To: kaos@ocs.com.au
Cc: Randy Dunlap <randy.dunlap@intel.com>, lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, your patch solved my USB module dependency
problems.

>This patch against 2.4.0-test10-pre6 implements
>LINK_FIRST and
> LINK_LAST to fix the problem with usb initialization
>order.  The patch *only* affects drivers/usb

__________________________________________________
Do You Yahoo!?
Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
