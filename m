Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVHLBpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVHLBpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHLBpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:45:10 -0400
Received: from fmr23.intel.com ([143.183.121.15]:22763 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932444AbVHLBpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:45:09 -0400
Date: Thu, 11 Aug 2005 18:44:52 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, steiner@sgi.com, dvhltc@us.ibm.com,
       mbligh@mbligh.org
Subject: Re: allow the load to grow upto its cpu_power (was Re: [Patch] don't kick ALB in the presence of pinned task)
Message-ID: <20050811184451.C581@unix-os.sc.intel.com>
References: <20050801174221.B11610@unix-os.sc.intel.com> <20050802092717.GB20978@elte.hu> <20050809160813.B1938@unix-os.sc.intel.com> <42F94A00.3070504@yahoo.com.au> <20050809190352.D1938@unix-os.sc.intel.com> <1123729750.5188.13.camel@npiggin-nld.site> <20050811111411.A581@unix-os.sc.intel.com> <42FBE410.9070809@yahoo.com.au> <20050811173917.B581@unix-os.sc.intel.com> <42FBFA3E.1070706@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42FBFA3E.1070706@yahoo.com.au>; from nickpiggin@yahoo.com.au on Fri, Aug 12, 2005 at 11:24:14AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 11:24:14AM +1000, Nick Piggin wrote:
> I'm not saying that I would reject any patch that did this or changed
> behaviour in the way that you would propose, however I would like
> to merge the version I sent as a bug fix first.

Please go ahead. Depending on the need, we will revisit this when we add
CMP enhancements.

thanks,
suresh
