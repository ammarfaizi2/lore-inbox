Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbTIRHmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbTIRHmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:42:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44191 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263004AbTIRHl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:41:59 -0400
Date: Thu, 18 Sep 2003 09:41:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, linstab@lists.osdl.org
Subject: Re: [osdl-aim-7] AS/CFQ/deadline runs
Message-ID: <20030918074153.GV906@suse.de>
References: <200309031937.h83JbFL18138@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031937.h83JbFL18138@mail.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03 2003, Cliff White wrote:
> 
> >From OSDL STP, on the 4-cpu platform
> OSDL-aim-7 test, using the new_dbase workload. 
> 
> AS looks very good, tho i will be repeating for confirmation. 
> (Would be happier if both runs were on same machine)
> I was told that CFQ is still WIP,
> test was already on a machine when i found out, so it's included.

It is still WIP, but I do appreciate seeing results like this just to
verify that there are no regressions for non-desktop type uses.

-- 
Jens Axboe

