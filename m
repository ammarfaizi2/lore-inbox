Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVEMG1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVEMG1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVEMG1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:27:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41161 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262259AbVEMG1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:27:03 -0400
Date: Fri, 13 May 2005 11:57:09 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Tony Lindgren <tony@atomide.com>, Lee Revell <rlrevell@joe-job.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050513062709.GE23705@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115913679.20909.31.camel@mindpipe> <20050512161636.GA15653@atomide.com> <200505120928.55476.jesse.barnes@intel.com> <20050512171251.GA21656@in.ibm.com> <4283999F.8080609@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283999F.8080609@virtuousgeek.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 10:59:59AM -0700, Jesse Barnes wrote:
> The latest patches seem to do tick skipping rather than wholesale 
> ticklessness.  Admittedly, the latter is a more invasive change, but one 

If you are referring to my i386 patch, that was only a hack to test the
scheduler change!

> that may end up being simpler in the long run.  But maybe George did a 
> design like that in the past and rejected it?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
