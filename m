Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTIRPuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTIRPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 11:50:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:21410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261660AbTIRPuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 11:50:03 -0400
Message-Id: <200309181549.h8IFnxK13109@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       linstab@lists.osdl.org
Subject: Re: [osdl-aim-7] AS/CFQ/deadline runs 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Thu, 18 Sep 2003 09:41:53 +0200." <20030918074153.GV906@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Sep 2003 08:49:59 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 03 2003, Cliff White wrote:
> > 
> > >From OSDL STP, on the 4-cpu platform
> > OSDL-aim-7 test, using the new_dbase workload. 
> > 
> > AS looks very good, tho i will be repeating for confirmation. 
> > (Would be happier if both runs were on same machine)
> > I was told that CFQ is still WIP,
> > test was already on a machine when i found out, so it's included.
> 
> It is still WIP, but I do appreciate seeing results like this just to
> verify that there are no regressions for non-desktop type uses.
> 
Thanks, we've changed the autotest so that we now run deadline,CFQ and AS
http://developer.osdl.org/cliffw/reaim/index.html

> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


