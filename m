Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268650AbUIQJj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbUIQJj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUIQJj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:39:59 -0400
Received: from twiddle.criticalpath.it ([192.92.105.100]:4844 "EHLO
	twiddle.syswiz.it") by vger.kernel.org with ESMTP id S268650AbUIQJj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:39:58 -0400
Message-ID: <414AB129.1050100@criticalpath.net>
Date: Fri, 17 Sep 2004 11:40:57 +0200
From: Andrea Carpani <andrea.carpani@criticalpath.net>
Reply-To: andrea.carpani@criticalpath.net
Organization: Critical Path
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040901
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SATA Sil 3114 Hotplug
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody: is hotplug for the SATA 3114 chipset by Silicon Image 
supposed to work?

I've got a Tyan B2882 GX28 wth an embedded Sil 3114 controller.
Linux kernel is 2.6.8.1
The system sees 2 Maxtor drives (sda and sdb) and as far as raid1 
creation everything seems to work fine. (sata ports 1 and 2)

The problem is that the i/o subsystem seems to freeze whenever I 
hot-remove one of the raid1 drives.

Any Info would be appreciated, thanks.

-- 

.a.c.
Andrea Carpani
<andrea.carpani@criticalpath.net>


