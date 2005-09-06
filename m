Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVIFWrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVIFWrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVIFWrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:47:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12185 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751087AbVIFWrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:47:51 -0400
Date: Tue, 6 Sep 2005 15:29:20 -0700
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: mel@csn.ul.ie, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       jschopp@austin.ibm.com, Simon.Derr@bull.net, torvalds@osdl.org,
       haveblue@us.ibm.com
Subject: Re: [PATCH 0/4] cpusets mems_allowed constrain GFP_KERNEL, oom
 killer
Message-Id: <20050906152920.5b12c7cf.pj@sgi.com>
In-Reply-To: <20050906010822.5cb635c0.pj@sgi.com>
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
	<20050906010822.5cb635c0.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Yesterday, I wrote:
> Please throw away the following 4 patches in 2.6.13-mm1:
> 
>   cpusets-oom_kill-tweaks.patch
>   cpusets-new-__gfp_hardwall-flag.patch
>   cpusets-formalize-intermediate-gfp_kernel-containment.patch
>   cpusets-confine-oom_killer-to-mem_exclusive-cpuset.patch


Looks like you sent these 4 patches onto Linus before you saw
the above.

That's fine, no problem.  I will work on top of these patches
now that they are in Linus's tree.

Just forget I asked you to throw them away.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
