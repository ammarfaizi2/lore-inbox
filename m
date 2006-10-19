Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946075AbWJSHeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946075AbWJSHeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946074AbWJSHeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:34:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61316 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946075AbWJSHeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:34:12 -0400
Date: Thu, 19 Oct 2006 00:34:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061019003405.15a4dd8c.pj@sgi.com>
In-Reply-To: <4537238A.7060106@yahoo.com.au>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<45361B32.8040604@yahoo.com.au>
	<20061018231559.8d3ede8f.pj@sgi.com>
	<45371CBB.2030409@yahoo.com.au>
	<20061018235746.95343e77.pj@sgi.com>
	<4537238A.7060106@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> (we simply shouldn't allow
> situations where we put a partition in the middle of a cpuset).

Could you explain to me what you mean by "put a partition in the
middle of a cpuset?"

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
