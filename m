Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUDGC7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUDGC7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:59:11 -0400
Received: from web41014.mail.yahoo.com ([66.218.93.13]:1674 "HELO
	web41014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263784AbUDGC7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:59:09 -0400
Message-ID: <20040407025908.30188.qmail@web41014.mail.yahoo.com>
Date: Tue, 6 Apr 2004 19:59:08 -0700 (PDT)
From: Linux Tard <linuxtard@yahoo.com>
Subject: Question regarding odd sector hard disk
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know in 2.4 kernel Linux could not access the last
sector of a hard disk if it were odd.

Combing the archives shows there was some possible
work being done on this for 2.6.

However, I can't find anything confirming this has
either been fixed in 2.6 or is still on the TODO list.

Has the block layer been fixed such that hard disks
with an odd sector count can be fully accessed within
Linux (access the last sector)?

kind regards,

lt

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
