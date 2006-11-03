Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752875AbWKCA7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbWKCA7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbWKCA7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:59:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:10510 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1752851AbWKCA7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:59:12 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,382,1157353200"; 
   d="scan'208"; a="11021317:sNHT18331695"
Message-ID: <454A945D.9020000@intel.com>
Date: Fri, 03 Nov 2006 08:59:09 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] i386 create e820.c to handle standard io/mem resources
References: <4540AA97.3030301@intel.com> <200611021831.56819.ak@suse.de>
In-Reply-To: <200611021831.56819.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will resubmit against latest git tree in one patch.

thanks
bibo,mao

Andi Kleen wrote:
> On Thursday 26 October 2006 14:31, bibo,mao wrote:
>  > This patch creates new file named e820.c to hanle standard io/mem
>  > resources, moving request_standard_resources function from setup.c
>  > to e820.c. Also this patch modifies Makfile to compile file e820.c.
> 
> I dropped all these patches because they didn't apply anymore.
> Can you please resubmit against latest kernel? Doing it in a single
> patch is ok.
> 
> Thanks,
> -Andi
> 
