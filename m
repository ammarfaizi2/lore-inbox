Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266989AbUBGRkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 12:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266992AbUBGRkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 12:40:42 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:4363 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266989AbUBGRkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 12:40:41 -0500
Subject: Unknown symbol _exit when compiling VMware vmmon.o module
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 07 Feb 2004 18:40:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After installing VMware Workstation 4.5.0-7174 and running
vmware-config.pl, I get the following error when trying to insert
vmmon.ko into the kernel:

vmmon: Unknown symbol _exit

What can I use instead of _exit(code) inside a module?
Thanks!

