Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWGUHOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWGUHOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 03:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWGUHOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 03:14:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30436 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030462AbWGUHOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 03:14:37 -0400
Date: Fri, 21 Jul 2006 00:14:31 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, sivanich@sgi.com
Subject: Re: [BUG] Cpuset: dynamic sched domain crash on > 16 cpu systems.
Message-Id: <20060721001431.f1fecf97.pj@sgi.com>
In-Reply-To: <20060720230909.A4984@unix-os.sc.intel.com>
References: <20060720132959.31161.284.sendpatchset@v0>
	<20060720230909.A4984@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> I don't have these type of systems. So can you please check if the appended
> patch fixes your issue.

Good - that fixes it.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
