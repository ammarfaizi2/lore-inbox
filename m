Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267153AbUBMSYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267154AbUBMSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:24:12 -0500
Received: from web41505.mail.yahoo.com ([66.218.93.88]:52826 "HELO
	web41505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267153AbUBMSYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:24:07 -0500
Message-ID: <20040213182405.63131.qmail@web41505.mail.yahoo.com>
Date: Fri, 13 Feb 2004 13:24:05 -0500 (EST)
From: Shu Lin <linshu99@yahoo.com>
Subject: output of printk can NOT be found in /var/log/messages
To: linux-kernel@vger.kernel.org
Cc: linshu99@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am debugging a module like below. I can get the
printk output in
/var/log/messages when i insmod and rmmmod. But when i
try to open or
ioctl the device, the output of printk doesn't appear
in
/var/log/messages.

What did i do wrong?

I also dumped /proc/sys/kernel/printk and
/etc/syslog.conf. But, i
don't think i had any configuration wrong.

Thanks ahead!

Shu
cc: linshu99@yahoo.com

______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
