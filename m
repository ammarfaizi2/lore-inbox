Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVBKAri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVBKAri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 19:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVBKArh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 19:47:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:50850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261983AbVBKArf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 19:47:35 -0500
Date: Thu, 10 Feb 2005 16:47:27 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com,
       Chris Wright <chrisw@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050210164727.M24171@build.pdx.osdl.net>
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050211000425.GC2474@waste.org>; from mpm@selenic.com on Thu, Feb 10, 2005 at 04:04:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> What happened to the RT rlimit code from Chris?

I still have it, but I had the impression Ingo didn't like it as a long
term solution/hack (albeit small) to the scheduler.  Whereas the rt-lsm
patch is wholly self-contained.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
