Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbTBXRrn>; Mon, 24 Feb 2003 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBXRrn>; Mon, 24 Feb 2003 12:47:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18314 "EHLO water.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264754AbTBXRrm>;
	Mon, 24 Feb 2003 12:47:42 -0500
Subject: lmbench automated testing
From: Nathan Dabney <smurf@osdl.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@bitmover.com>
In-Reply-To: <200302241735.h1OHZw130888@mail.osdl.org>
References: <200302241735.h1OHZw130888@mail.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046109446.16359.18.camel@water.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 09:57:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 24, 2003 at 11:23:14AM -0500, Benjamin LaHaise wrote:
> > kernel for specific applications.  I'm curious if there is a collection 
> > of lmbench results of hand configured and compiled kernels vs the vendor 
> > module based kernels across 2.0, 2.2, 2.4 and recent 2.5 on the same 
> > uniprocessor and dual processor configuration.  
> 
> If someone were willing to build the init script infra structure to 
> reboot to a new kernel, run the test, etc., I'll buy a couple of 
> machines and just let them run through this.  I'd like to do it 
> with the cache miss counters turned on so if P4's do a nicer job
> of counting than Athlons, I'll get those.
> - -- 
> - ---
> Larry McVoy            	 lm at bitmover.com           

Larry,

  We already do that and provide 1, 2, 4 and 8 way machines for our
testing targets.

  Lmbench is already available as an automated test on the STP system.

http://www.osdl.org/stp


-Nathan Dabney
Open Source Development Lab

