Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWCZCls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWCZCls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 21:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWCZCls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 21:41:48 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:52659 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751309AbWCZClr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 21:41:47 -0500
Date: Sun, 26 Mar 2006 08:11:44 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question on build_sched_domains
Message-ID: <20060326024144.GB2998@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060324025834.GD8903@in.ibm.com> <20060324071255.GB22150@in.ibm.com> <4423A391.4000301@yahoo.com.au> <20060325083619.GC17011@in.ibm.com> <4425FAB0.70909@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4425FAB0.70909@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 12:21:36PM +1000, Nick Piggin wrote:
> I don't see why. It should be changed to GFP_KERNEL.

Thats what I thought too. Will submit a patch to that effect, while I am
cleaning up build_sched_domains.

-- 
Regards,
vatsa
