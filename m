Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbULEPSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbULEPSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 10:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULEPSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 10:18:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21996 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261175AbULEPSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 10:18:47 -0500
Date: Sun, 5 Dec 2004 16:18:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Ed Tomlinson <edt@aei.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
Message-ID: <20041205151840.GE6430@suse.de>
References: <20041204104921.GC10449@suse.de> <200412050921.20468.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412050921.20468.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05 2004, Ed Tomlinson wrote:
> Jens,
> 
> Booting 10-rc3 with this patch applied hangs when I su from root
> to my working user.  Same kernel without elevator=cfq works.   By
> hangs I mean that the su does not complete nor do logins to other
> ids work.  The sysrq keys are active.  
> 
> Please let me know what other info will help.

What type of storage is involved, that's the main question?

-- 
Jens Axboe

