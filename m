Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTFJPl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFJPl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:41:57 -0400
Received: from web14914.mail.yahoo.com ([216.136.225.241]:55817 "HELO
	web14914.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263315AbTFJPlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:41:52 -0400
Message-ID: <20030610155532.35065.qmail@web14914.mail.yahoo.com>
Date: Tue, 10 Jun 2003 11:55:32 -0400 (EDT)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: about bdflush
To: linux-kernel@vger.kernel.org
Cc: kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys, I have a small question about
/proc/sys/vm/bdflush . I am working on a SMP machine.
The kernel version is 2.4.18. I want to modify the
content of /proc/sys/vm/bdflush. But once I modify the
content, it will go back to the default value after I
reboot the OS. Is there a way by which I can
permanently change the content of this file? The OS
keeps the default value in somewhere? 

Thanks in advance.



______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
