Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTK3VLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTK3VLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 16:11:06 -0500
Received: from bay7-f79.bay7.hotmail.com ([64.4.11.79]:2830 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263241AbTK3VLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 16:11:04 -0500
X-Originating-IP: [209.98.246.157]
X-Originating-Email: [joeblow341@hotmail.com]
From: "Joe Blow" <joeblow341@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Promise 20378 + 2.6.0-test10 + libata patch 1
Date: Sun, 30 Nov 2003 21:11:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F79JONRxh4e7Ob0001b5ff@hotmail.com>
X-OriginalArrivalTime: 30 Nov 2003 21:11:03.0485 (UTC) FILETIME=[764E4ED0:01C3B786]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have applied the libata patch 1 to kernel 2.6.0-test10.  I can now see the 
PDC RAID controller via the hardware browser, but I can not see any of the 
attatched PATA drives.  (I do not have any SATA drives).

I have tried the controller set to RAID and IDE.  I can not locate the 
attached PATA drives in /proc/ide or /proc/scsi, nor does the hardware 
browser see them.  I #define ATA_VERBOSE_DEBUG and I did not find any 
addtional output in dmesg.

Does this driver not support PATA drives attatched to this controller?

Thanks for any help.

_________________________________________________________________
Groove on the latest from the hot new rock groups!  Get downloads, videos, 
and more here.  http://special.msn.com/entertainment/wiredformusic.armx

