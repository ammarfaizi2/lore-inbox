Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTI2Puq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTI2Pup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:50:45 -0400
Received: from web40910.mail.yahoo.com ([66.218.78.207]:7347 "HELO
	web40910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263633AbTI2Pun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:50:43 -0400
Message-ID: <20030929155042.53666.qmail@web40910.mail.yahoo.com>
Date: Mon, 29 Sep 2003 08:50:42 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

I am experiencing defunct event/0 kernel daemons under 2.6.0-test6-mm1
with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20 with synaptics
support, and XFree86 4.3.0-10. Moving the touchpad in either X or with
gpm causes defunct event/0 processes to be created. This didn't happen
with 2.6.0-test5-mm4, using either synaptics_drv 0.11.6 or 0.11.7, and
I'm pretty sure that it didn't happen with 2.6.0-test6, but I will check
that.

I see in your e-mail here: 

http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0926.html

that you merged a synaptics update in the -mm1 patchset. Do you have a
link to this patch so that I can revert it and see if it still occurs?

TIA

Brad Chapman

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
