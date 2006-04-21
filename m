Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWDUQ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWDUQ7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWDUQ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:59:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:31717 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932421AbWDUQ7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:59:09 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <1145630992.3373.6.camel@localhost.localdomain>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Fri, 21 Apr 2006 09:58:42 -0700
Message-Id: <1145638722.14804.0.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 07:49 -0700, Dave Hansen wrote:
> On Thu, 2006-04-20 at 19:24 -0700, sekharan@us.ibm.com wrote:
> > CKRM has gone through a major overhaul by removing some of the complexity,
> > cutting down on features and moving portions to userspace.
> 
> What do you want done with these patches?  Do you think they are ready
> for mainline?  -mm?  Or, are you just posting here for comments?
> 

We think it is ready for -mm. But, want to go through a review cycle in
lkml before i request Andrew for that.

Thanks for asking,

chandra
> -- Dave
> 
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


