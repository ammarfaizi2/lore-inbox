Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbUKLJ2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbUKLJ2Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 04:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUKLJ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 04:28:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11998 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262237AbUKLJ2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 04:28:22 -0500
Date: Fri, 12 Nov 2004 10:27:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-ID: <20041112092748.GZ11488@suse.de>
References: <20041111012333.1b529478.akpm@osdl.org> <20041111030837.12a2090b.akpm@osdl.org> <111920000.1100210158@flay> <20041111141403.757ea983.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111141403.757ea983.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It doesn't boot on a 4-way itanium tiger, hangs right after:

[...]
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
atkbd.c: keyboard reset failed on isa0060/serio1
atkbd.c: keyboard reset failed on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EFI Variables Facility v0.08 2004-May-17
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1

-- 
Jens Axboe

