Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265192AbUENLFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbUENLFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUENLFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:05:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265250AbUENLFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:05:05 -0400
Date: Fri, 14 May 2004 13:04:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: raghav@in.ibm.com, akpm@osdl.org, maneesh@in.ibm.com, dipankar@in.ibm.com,
       torvalds@osdl.org, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040514110427.GG17326@suse.de>
References: <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <20040508201259.GA6383@in.ibm.com> <20041006125824.GE2004@in.ibm.com> <20040511132205.4b55292a.akpm@osdl.org> <20040514103322.GA6474@in.ibm.com> <20040514035039.347871e8.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514035039.347871e8.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14 2004, Paul Jackson wrote:
> > Looks like the new hashing function has brought down the performance.
> 
> "brought down the performance" as in "better, faster", right?
> 
> That is, your numbers show that the new hashing function is good, right?
> 
> Or do I have it backwards?

The numbers were ms/iteration, so I guess you do.

-- 
Jens Axboe

