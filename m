Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWGGAew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWGGAew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWGGAev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4742 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751133AbWGGAei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:38 -0400
Date: Thu, 6 Jul 2006 17:34:17 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: vatsa@in.ibm.com, nickpiggin@yahoo.com.au, mingo@elte.hu, hawkes@sgi.com,
       dino@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com, ak@suse.de
Subject: Re: [PATCH 2.6.16-mm1 2/2] sched_domains: Allocate sched_groups
 dynamically
Message-Id: <20060706173417.e7d1e39e.pj@sgi.com>
In-Reply-To: <20060706170824.E13512@unix-os.sc.intel.com>
References: <20060325082804.GB17011@in.ibm.com>
	<20060706170151.cdb1dc6c.pj@sgi.com>
	<20060706170824.E13512@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In short, multi-core was broken too and Srivatsa's patch fixed it.

Thanks for your quick response, Suresh.

My test earlier today that showed multi-core -not- broken must
have been flawed.

I will rerun them tomorrow, carefully.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
