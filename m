Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265906AbUFVV3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUFVV3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUFVV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:27:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:41105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265906AbUFVV1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:27:06 -0400
Date: Tue, 22 Jun 2004 14:27:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: walt <wa1ter@hotmail.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-bk] NFS-related kernel panic
Message-ID: <20040622142656.J22989@build.pdx.osdl.net>
References: <fa.l7nhc0k.1k1oepm@ifi.uio.no> <fa.gh5h9hv.b2sm3v@ifi.uio.no> <40D8A122.7020806@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40D8A122.7020806@hotmail.com>; from wa1ter@hotmail.com on Tue, Jun 22, 2004 at 02:14:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* walt (wa1ter@hotmail.com) wrote:
> Chris Wright wrote:
> 
> > The lockless loopback transmission patch mucks up the preempt count.
> > Can you give this patch a try?
> 
> I saw an update to loopback.c from linus which I assume was yours --
> anyway my panic is fixed.  Thanks.

Actually that's from Andrew, and Arthur sent in a minor tweak which has
yet to hit mainline.  Glad it's working.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
