Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUG2WoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUG2WoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267500AbUG2WhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:37:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14589 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267495AbUG2WfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:35:24 -0400
Subject: Re: arch_init_sched_domains() oops
From: Dave Hansen <haveblue@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200407291517.21613.jbarnes@engr.sgi.com>
References: <1091138180.23502.81.camel@nighthawk>
	 <200407291517.21613.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1091140502.23502.99.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 15:35:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 15:17, Jesse Barnes wrote:
> On Thursday, July 29, 2004 2:56 pm, Dave Hansen wrote:
> > This happened on a NUMA running 2.6.8-rc2-mm1:
> 
> Is this stock 2.6.8-rc2-mm1?  If so, you may need the attached patch.

Thanks.  That did it.

-- Dave

