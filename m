Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUJGFj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUJGFj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUJGFj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:39:28 -0400
Received: from stutter.bur.st ([202.61.227.61]:24580 "EHLO stutter.bur.st")
	by vger.kernel.org with ESMTP id S267283AbUJGFjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:39:25 -0400
Date: Thu, 7 Oct 2004 13:39:23 +0800
From: Trent Lloyd <lathiat@bur.st>
To: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: Why no linux-2.6.8.2? (was Re: new dev model)
Message-ID: <20041007053923.GA4721@sweep.bur.st>
References: <200410070134_MC3-1-8BA9-A215@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410070134_MC3-1-8BA9-A215@compuserve.com>
X-Random-Number: 1.82855051198056e+39
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck,

We don't usually make a 4th point in our versions, the next version
after 2.6.8 would usually be 2.6.9, which will come out in due course.

2.6.8.1 was released because there was a 1-line error in 2.6.8 that
completely stopped NFS from working.

The patches mentioned below will probably go into 2.6.9 or something, if
they have been approved for it etc.

Hope that clears it up.

Cheers,
Trent
Bur.st

> Why has linux 2.6.8 been abandoned at version 2.6.8.1?
> 
> There exist fixes that could go into 2.6.8.2:
> 
>         process start time doesn't match system time
>         FDDI frame doesn't allow 802.3 hwtype
>         NFS server using XFS filesystem on SMP machine oopses
> 
> I'm sure there are more...
> 
> So why is 2.6.8.1 a "dead branch?"
> 
> 
> --Chuck Ebbert
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
