Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264159AbUENFER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264159AbUENFER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUENFER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:04:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:17031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264159AbUENFEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:04:16 -0400
Date: Thu, 13 May 2004 22:04:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2)
Message-ID: <20040513220415.E22989@build.pdx.osdl.net>
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <200405131945.53723.luto@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405131945.53723.luto@myrealbox.com>; from luto@myrealbox.com on Thu, May 13, 2004 at 07:45:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> As for Posix caps, is there any good reason to follow Posix?  I
> don't know of any OS that has Posix caps except Linux, and they're
> broken.  The spec was dropped, anyway.

Well, I wonder what IRIX does?  They support capabilities and had a
reasonable sized hand in the draft.  No point in making it impossible
to port apps.  It's not that I'm a strong fan of Posix caps, but
compatibility (even with a partially complete draft) with defacto
standards is not entirely unreasonable.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
