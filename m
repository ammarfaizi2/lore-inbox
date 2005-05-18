Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVERVFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVERVFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVERVFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:05:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14722 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262370AbVERVEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:04:42 -0400
Date: Wed, 18 May 2005 14:04:22 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, colpatch@us.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org
Subject: Re: [Lse-tech] Re: [RFT PATCH] Dynamic sched domains (v0.6)
Message-Id: <20050518140422.4b49febc.pj@sgi.com>
In-Reply-To: <20050518180652.GA4293@in.ibm.com>
References: <20050517041031.GA4596@in.ibm.com>
	<20050517225354.025c3cca.pj@sgi.com>
	<20050518180652.GA4293@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> I tried your script and see that it makes absolutely no impact on top.
> The CPU on which it is running is mostly 100% idle. However I'll run
> more tests to confirm that it has no impact

I have no particular intuition, one way or the other, on how much a
dynamic reallocation of sched domains will impact the system.  So
once you are comfortable that this is not normally a problem (which
you might already be), don't worry about it further on my account.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
