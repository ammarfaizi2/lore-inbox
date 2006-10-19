Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946278AbWJSRzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946278AbWJSRzr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946280AbWJSRzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:55:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19377 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946278AbWJSRzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:55:46 -0400
Date: Thu, 19 Oct 2006 10:55:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061019105515.080675fb.pj@sgi.com>
In-Reply-To: <453750AA.1050803@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> This should be done outside cpusets.

So ... where should it be done?

And what would be better about that other place?

And by the way, I see in another patch you put some other
stuff for configuring sched domains in the root cpuset.
If the root cpuset was the right place for that, why isn't
it the right place for this? ... strange.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
