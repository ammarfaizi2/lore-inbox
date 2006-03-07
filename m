Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWCGDlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWCGDlN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWCGDlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:41:13 -0500
Received: from c-68-35-68-128.hsd1.nm.comcast.net ([68.35.68.128]:14294 "EHLO
	deneb.dwf.com") by vger.kernel.org with ESMTP id S932648AbWCGDlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:41:11 -0500
Message-Id: <200603070340.k273ev0A003594@deneb.dwf.com>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Mar 2006 20:40:57 -0700
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im still running a 2.6.11 
Ever since some PCI changes (between 2.6.11 and 2.6.15) I have been
unable to build a kernel that will run with my machine on an 
Intel D945 Motherboard.

I just tried vmlinuz-2.6.16-rc5-git8 and still no luck, the kernel builds,
but during the first few lines of the boot you get the message:

    PCI: Failed to allocate mem resource #6 ...

Ive tried stripping things down to just the video card, and still the same
result.

This Motherboard has been available for the better part of a year, and
still no Linux support.  Usually by the time I buy something, its supported.

Anyone working this problem?

-- 
                                        Reg.Clemens
                                        reg@dwf.com


