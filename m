Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUIXSQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUIXSQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269083AbUIXSQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:16:10 -0400
Received: from web8507.mail.in.yahoo.com ([202.43.219.169]:42599 "HELO
	web8507.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S269076AbUIXSOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:14:49 -0400
Message-ID: <20040924181446.76148.qmail@web8507.mail.in.yahoo.com>
Date: Fri, 24 Sep 2004 19:14:46 +0100 (BST)
From: Dinesh Ahuja <mdlinux7@yahoo.co.in>
Subject: Problem in Loading Modules.
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have purchased a book "Linux Device Drivers" By
Alessandro Rubini. I have an eagerness to learn the
Kernel Programming and this is my first step.

I request all of you to help me resolving my problems
as I have this mailing list as a only source to leanr
Kernel Programming.

I have read the example hello.c which illustrates a
simple module.

I was not able to load a module in a running Kernel
2.4.20-6 [ comes with Red Hat Linux 9.0] as it gives
me a following error:

[root@localhost KernelProg]# insmod ./helloMod.o
./helloMod.o: kernel-module version mismatch
        ./helloMod.o was compiled for kernel version
2.4.20
        while this kernel is version 2.4.20-6.


Please guide me how to proceed further in loading this
example module.

Thanks & Regards
Dinesh



________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
