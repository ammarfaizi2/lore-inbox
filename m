Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUHBUQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUHBUQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUHBUQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:16:56 -0400
Received: from web52210.mail.yahoo.com ([206.190.39.92]:35180 "HELO
	web52210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263019AbUHBUQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:16:32 -0400
Message-ID: <20040802201632.35804.qmail@web52210.mail.yahoo.com>
Date: Mon, 2 Aug 2004 13:16:32 -0700 (PDT)
From: "Alexander Sirotkin \[at Yahoo\]" <alex_s_42@yahoo.com>
Subject: kernel freeze when mounting dvd
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running FC2 with kernel 2.6.5. When I try to mount
DVD disks my system freezes. Mounting CDs works just
fine. DVD works OK on Windows. After freeze there are
no messages in the logs, however if I do it in
runlevel 3 I see an endless loop of printk's running
on the screen saying something about not being able to
read some block. I can't cat-n-paste the message
because it does not go to any log. And I don't use
SCSI emulation, I just mount it as /dev/hdd.  My DVD
drive is LITE-ON DVDRW SOHW-812S.

Any ideas ? Thanks .


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
