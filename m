Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTLQScx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbTLQScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:32:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34214 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264509AbTLQScw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:32:52 -0500
Date: Wed, 17 Dec 2003 19:32:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Voegtle <thomas@voegtle-clan.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Message-ID: <20031217183250.GC2495@suse.de>
References: <20031217164832.GA2495@suse.de> <Pine.LNX.4.21.0312171832120.32429-100000@needs-no.brain.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0312171832120.32429-100000@needs-no.brain.uni-freiburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17 2003, Thomas Voegtle wrote:
> On Wed, 17 Dec 2003, Jens Axboe wrote:
> 
> > 
> > Apply this to test11-bkLATEST
> > 
> > ===== drivers/block/scsi_ioctl.c 1.38 vs edited =====
> > --- 1.38/drivers/block/scsi_ioctl.c	Thu Dec 11 18:55:17 2003
> 
> Yes, this fixes the problem.
> I have now 2.6.0-test11-bk13 + patch.

Great, thanks for testing. Patch is in Linus' in-queue.

-- 
Jens Axboe

