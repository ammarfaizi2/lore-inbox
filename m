Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUAVXJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUAVXJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:09:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:1454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266472AbUAVXJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:09:43 -0500
Date: Thu, 22 Jan 2004 15:09:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: security patches / lsm
Message-ID: <20040122150937.A8720@osdlab.pdx.osdl.net>
References: <20040122191158.GA1207@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040122191158.GA1207@schottelius.org>; from nico-kernel@schottelius.org on Thu, Jan 22, 2004 at 08:11:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nico Schottelius (nico-kernel@schottelius.org) wrote:
> What about the LSM framework in the kernel and the arguments at
>    http://www.rsbac.org/lsm.htm
>    http://www.grsecurity.net/lsm.php

It's been fairly functional for something as comprehenseive as SELinux,
and supports other users as well, LIDS, DTE come to mind.  There are
probably some improvements we could make from a few of the complaints
from these projects, however they haven't contacted the lsm list in years.

> Are you working together with those maintainers to enable their
> patches?

No.  They've both said they don't want to spend any time on such
endeavor.  I think it would be time well spent, perhaps you'd like to
help?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
