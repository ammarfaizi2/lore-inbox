Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUIERY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUIERY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 13:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUIERY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 13:24:29 -0400
Received: from host213-106-240-81.no-dns-yet.ntli.net ([213.106.240.81]:23308
	"EHLO cus.org.uk") by vger.kernel.org with ESMTP id S266885AbUIERY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 13:24:27 -0400
Date: Sun, 5 Sep 2004 18:24:36 +0100 (BST)
From: Alex Owen <owen@cus.org.uk>
To: glen.turner@aarnet.edu.au
cc: linux-kernel@vger.kernel.org
Subject: Linux serial console patch
Message-ID: <20040905175037.O58184@cus.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glen Turner,

I have read your posts to lkml containing your serial console flow control
patches firstly for 2.4.x and then for 2.6.x kernels.

Rationale:
 "[PATCH] 0/3 Fix serial console flow control"
    http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1790.html
2.4 patches:
 "[PATCH] 1/3 Fix serial console flow control, serial.c"
    http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1791.html
 "[PATCH] 2/3 Fix serial console flow control, serialP.h"
    http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1792.html
 "[PATCH] 3/3 Fix serial console flow control, serial-console.txt"
    http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1793.html
2.6 patch:
 "[PATCH] Fix CTS/RTS flow control in serial console"
    http://www.ussg.iu.edu/hypermail/linux/kernel/0310.2/1080.html

I have not been able to find any feedback on those patches in the lkml
archives. Also I can find no evidence that the patch made it into the
2.6.8.1 kernel. This is a shame as I found your rationale very
persuasive.

Do you maintain an up-to-date version of this patch?
Did you get any feedback for this patch, positive or negative?
Do you need people (i.e. me) to test this patch?

Thanks
Alex Owen
