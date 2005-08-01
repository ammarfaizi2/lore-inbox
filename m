Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVHALNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVHALNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 07:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVHALNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 07:13:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31901 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262174AbVHALNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 07:13:31 -0400
Date: Mon, 1 Aug 2005 13:15:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Tobias <kernelmail@icht.homelinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.3 2.6.11.6 2.6.12  2.6.13rc3 +rc4 Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
Message-ID: <20050801111525.GQ22569@suse.de>
References: <20050731160704.eopkg4w04ggcg8kc@www.fujitsu.ti> <20050801130602.499nu645gksckc8g@www.fujitsu.ti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801130602.499nu645gksckc8g@www.fujitsu.ti>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01 2005, Tobias wrote:
> >Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
> >[<c0249559>] blk_remove_plug+0x69/0x70
> >[<c024957a>] __generic_unplug_device+0x1a/0x30
> >[<c024ac88>] __make_request+0x248/0x5a0

This looks very very strange. Please detail your storage setup. Your
attached files appear to be corrupted, I cannot read them.

-- 
Jens Axboe

