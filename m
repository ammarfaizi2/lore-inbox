Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUJ0OPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUJ0OPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUJ0OPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:15:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:8580 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262451AbUJ0OPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:15:20 -0400
Message-ID: <417FAED5.7070603@sgi.com>
Date: Wed, 27 Oct 2004 09:21:09 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com> <20041027064851.GW15367@holomorphy.com>
In-Reply-To: <20041027064851.GW15367@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> 
>>Hugetlb demand paging has been part of SuSE SLES 9 for awhile now and
>>this patchset is intended to help hugetlb demand paging also get into
>>the official Linux kernel. Huge pages are referred to as "compound"
>>pages in terms of "struct page" in the Linux kernel. The term
> 
> "compund page" may be used alternatively to huge page.
> 
> This may very well explain why SLES9 is triplefaulting when Oracle
> tries to use hugetlb on it on x86-64.
> 
> Since all this is clearly malfunctioning and not done anywhere near
> carefully enough, can I at least get *some* sanction to do any of this
> differently?
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

How differently?  What do you have in mind?

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
