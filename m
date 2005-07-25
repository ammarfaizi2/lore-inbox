Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVGYH1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVGYH1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGYH1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:27:42 -0400
Received: from bay17-f4.bay17.hotmail.com ([64.4.43.54]:37537 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261735AbVGYH1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:27:33 -0400
Message-ID: <BAY17-F4D75DC4B383C374A1BCD3BCCA0@phx.gbl>
X-Originating-IP: [212.199.150.124]
X-Originating-Email: [zvidubitzki@hotmail.com]
From: "zvi Dubitzki" <zvidubitzki@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: accessing CD fs from initrd
Date: Mon, 25 Jul 2005 07:27:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Jul 2005 07:27:32.0468 (UTC) FILETIME=[5222B340:01C590EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I want to be CC-ed on a possible answer to the following question.
I have not found yet an answer to the question in the Linux archives.

In need access the CD filesystem (iso9660) from within the Linux initrd or 
right after that (make it root fs).
I need an example for that since allocating enough ramdisk space 
(ramdisk_size=90k in kernel command line)  + loading the cdrom.o
module at the initrd did not help  mount the CD device (/dev/cdrom)  at the 
initrd
Also I need know how to pivot between the initrd and the CD filesystem

I am actually using Isolinux/syslinux, but can make test on a regular Linux 
.
Any pointer to a literature will also be welcomed .

thanks

Zvi Dubitzki

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

