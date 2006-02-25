Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWBYNqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWBYNqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWBYNqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:46:20 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:2518 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030237AbWBYNqT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:46:19 -0500
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg K-H <gregkh@suse.de>
Subject: usbfs2 panic [Was: 2.6.16-rc4-mm2]
In-reply-to: <20060224031002.0f7ff92a.akpm@osdl.org>
Message-Id: <E1FCzkA-0005fe-00@decibel.fi.muni.cz>
Date: Sat, 25 Feb 2006 14:45:54 +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/
[...]
Hello,

I catched this oops through booting due to Greg's inode usbfs2 patch.
Here is camera-snapshot of the screen:
http://www.fi.muni.cz/~xslaby/sklad/panic.gif
Config:
http://www.fi.muni.cz/~xslaby/sklad/config-desk

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
