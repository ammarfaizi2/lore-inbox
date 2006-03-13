Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWCMVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWCMVqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWCMVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:46:50 -0500
Received: from mail.usrealtorsltd.com ([69.222.0.23]:61700 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S932467AbWCMVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:46:50 -0500
Date: Mon, 13 Mar 2006 15:46:35 -0600
Message-Id: <200603131546.AA25035310@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <mingo@elte.hu>
Subject: 2.6.16-rc6-rt2 - fs/xfs compilation problem - mutex_destroy undefined!
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@vger.kernel.org
mingo@elte.hu


CHK     usr/initramfs_list
Kernel: arch/i386/boot/bzImage is ready  (#1)
Building modules, stage 2.
MODPOST
*** Warning: "mutex_destroy" [fs/xfs/xfs.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [fs/xfs/xfs.ko] undefined!

xboom
