Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUH3HMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUH3HMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUH3HMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:12:46 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:1033 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S265800AbUH3HMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:12:46 -0400
From: Meelis Roos <mroos@linux.ee>
To: nhorman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the   IDE bus)
In-Reply-To: <41326FE1.2050508@redhat.com>
User-Agent: tin/1.7.6-20040812 ("Gighay") (UNIX) (Linux/2.6.9-rc1 (i686))
Message-Id: <E1C1gLI-0001XZ-Fv@rhn.tartu-labor>
Date: Mon, 30 Aug 2004 10:12:40 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NH> I've not heard of SunDisk.  SunDisk->SanDisk == Typo?

Nope. It was called SunDisk at first but then Sun told them to change
their name and they changed it to SanDisk. There a CF disks with both
names in the wild. But there's no problem, recent kernels (both 2.4 and
2.6) recognize both names as CFA.

-- 
Meelis Roos
