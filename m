Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262978AbVDBBuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVDBBuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVDBBrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:47:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20883 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262964AbVDBBpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:45:20 -0500
Date: Fri, 1 Apr 2005 17:44:35 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-Id: <20050401174435.4117c940.pj@engr.sgi.com>
In-Reply-To: <200504012232.j31MWTg03706@unix-os.sc.intel.com>
References: <20050401064611.GA26203@elte.hu>
	<200504012232.j31MWTg03706@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth wrote:
> Paul, you definitely want to check this out on your large numa box.

Interesting - thanks.  I can get a kernel patched and booted on a big
box easily enough.  I don't know how to run an "industry db benchmark",
and benchmarks aren't my forte.

Should I rope in one of our guys who is benchmark savvy, or are there
some instructions you can point to for running an appropriate benchmark?

Or are we just interested, first of all, in what sort of values this
cost matrix gets initialized with (and how slow it is to compute)?

I can get time on a 64-cpu with a days notice, and time on a 512-cpu
with 2 or 3 days notice.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
