Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVGVA3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVGVA3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 20:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVGVA3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 20:29:04 -0400
Received: from dvhart.com ([64.146.134.43]:25528 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261958AbVGVA3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 20:29:03 -0400
Message-ID: <42E03DD2.6020308@mbligh.org>
Date: Thu, 21 Jul 2005 20:29:06 -0400
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
Cc: Matthew Helsley <matthltc@us.ibm.com>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, gh@us.ibm.com
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
References: <20050715013653.36006990.akpm@osdl.org>	<20050715150034.GA6192@infradead.org>	<20050715131610.25c25c15.akpm@osdl.org>	<20050717082000.349b391f.pj@sgi.com>	<1121985448.5242.90.camel@stark> <20050721163227.661a5169.pj@sgi.com>
In-Reply-To: <20050721163227.661a5169.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

>Matthew wrote:
>  
>
>Perhaps someone who knows CKRM better than I can explain why the CKRM
>version in some SuSE releases based on 2.6.5 kernels has substantial
>code and some large ifdef's in sched.c, but the CKRM in *-mm doesn't.
>Or perhaps I'm confused.  There's a good chance that this represents
>ongoing improvements that CKRM is making to reduce their footprint
>in core kernel code.  Or perhaps there is a more sophisticated cpu
>controller in the SuSE kernel.
>  
>

No offense, but I really don't see why this matters at all ... the stuff
in -mm is what's under consideration for merging - what's in SuSE is
wholly irrelevant ? One obvious thing is that that codebase will be
much older ... would be useful if people can direct critiques at the
current codebase ;-)

M.


