Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUHSJNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUHSJNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUHSJL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:11:56 -0400
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:58548 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S264386AbUHSJKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:10:18 -0400
Message-ID: <002301c485cc$3777fed0$9159023d@dreammachine>
From: "Pankaj Agarwal" <pankaj@pnpexports.com>
To: <linux-kernel@vger.kernel.org>
Subject: Help Root Raid
Date: Thu, 19 Aug 2004 14:39:14 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - pnpexports.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need your help regarding root raid. I have a root raid implemented server
and it not booting anymore. I tried to use that harddisc as secondary hard
disk to on of my other linux installation..so i can take a backup of files.
The other installation has raid precompiled....as in booting process it
checks for raid arays and at shutdown it gives messages regarding md
devices. however it doesn't show any dev in lsdev or /proc/mdstat. My
problem is when i try to mount it using "mount -t ext2 /dev/md0 /mnt/hdc1"
it gives me error as "wronf fs, bad option, bad superblock on
/dev/md0.........................(aren't you trying to mount a block device
on a logical device)". Kindly show me the way to mount the filesystem.

thanks and regards,

Pankaj Agarwal


