Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWHDLNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWHDLNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHDLNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:13:49 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:40636 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751415AbWHDLNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:13:48 -0400
Date: Fri, 4 Aug 2006 16:48:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ RFC, PATCH 1/5 ] CPU controller - base changes
Message-ID: <20060804111815.GB28490@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060804050932.GE27194@in.ibm.com> <20060804003528.da3722b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804003528.da3722b3.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:35:28AM -0700, Andrew Morton wrote:
> That's another 4.5kbytes/cpu of our precious per-cpu memory.  Is it feasible to make this
> dependent upon CONFIG_CPUMETER?

Yes I think. Will consider that in my next version.

-- 
Regards,
vatsa
