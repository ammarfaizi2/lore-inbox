Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTKMP3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 10:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTKMP2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 10:28:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54251 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264326AbTKMP2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 10:28:00 -0500
Date: Thu, 13 Nov 2003 16:28:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031113152801.GM4441@suse.de>
References: <RoMa.Mi.7@gated-at.bofh.it> <RpI1.2RG.5@gated-at.bofh.it> <RqNS.54j.11@gated-at.bofh.it> <E1AKJ20-0006Ek-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AKJ20-0006Ek-00@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Pascal Schmidt wrote:
> On Thu, 13 Nov 2003 15:40:20 +0100, you wrote in linux.kernel:
> 
> >> My patch from yesterday should handle that situation. 
> >> cdrom_get_last_written is allowed to override the capacity from
> >> cdrom_read_capacity.
> 
> > Yep, that is fine.
> 
> Will you queue the patch or should I resend it after 2.6.0 gets released?

If Linus doesn't want to take it now, send it later :)

-- 
Jens Axboe

