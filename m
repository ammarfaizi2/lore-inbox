Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVHPHoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVHPHoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 03:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVHPHoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 03:44:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965131AbVHPHoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 03:44:07 -0400
Date: Tue, 16 Aug 2005 00:44:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 0/6] i386 virtualization patches, Set 3
Message-ID: <20050816074405.GZ7762@shell0.pdx.osdl.net>
References: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> This patch set is based on 2.6.13-rc6 -mm1 broken out series.  It applies
> and builds i386, x86_64, and um-i386 on 2.6.13-rc5.  I've tested PAE and
> non-PAE SMP kernels and am working on an LDT test suite.  Depends on
> the i386 cleanups, sub-arch movement, and LDT cleanups I've already sent
> out.

I put these in the virt-2.6 git tree, with the one minor wrprotect macro
change I mentioned.

thanks,
-chris
