Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTAaWRF>; Fri, 31 Jan 2003 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTAaWRE>; Fri, 31 Jan 2003 17:17:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:28893 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262789AbTAaWRE>; Fri, 31 Jan 2003 17:17:04 -0500
Date: Fri, 31 Jan 2003 14:18:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David Mansfield <lkml@dm.cobite.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm7 results with database 'benchmark'
Message-ID: <287340000.1044051492@flay>
In-Reply-To: <Pine.LNX.4.44.0301311641050.17695-100000@admin>
References: <Pine.LNX.4.44.0301311641050.17695-100000@admin>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have run my 'production database load' against the 2.5.59-mm7 kernel.  
> Fortunately for me, but unfortunately for you, I have upgraded the system 
> CPUs.  They were 2 x PIII 866Mhz, 256kb cache, now 2 x PIII 1Ghz, 256kb 
> cache.  I reran the 2.4.18-19.7.xsmp test as a baseline for comparison.  I 
> include all results to date here.  System and workload descriptions 
> follow. 
> 
> The (slight) advantage that the 2.5.59 series had over the RedHat
> kernels has evaporated.  But it was marginal to begin with.
> 
> As usual, I'm willing to test...

You got any more detailed info? vmstat, oprofile / readprofile, 
things like that?

M.

