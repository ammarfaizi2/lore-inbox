Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWFZTAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWFZTAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWFZTA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:00:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53460 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932694AbWFZTAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:00:25 -0400
Message-ID: <44A02EC0.2070004@sgi.com>
Date: Mon, 26 Jun 2006 12:00:16 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: nagar@watson.ibm.com, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<20060609010057.e454a14f.akpm@osdl.org>	<448952C2.1060708@in.ibm.com>	<20060609042129.ae97018c.akpm@osdl.org>	<4489EE7C.3080007@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
In-Reply-To: <20060626113959.839d72bc.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 26 Jun 2006 11:26:53 -0700
> Jay Lan <jlan@sgi.com> wrote:
> 
> 
>>>OK, please send the patch and I'll plan on sending this lot to Linus
>>>Thursdayish.
>>
>>These new patches are fresh out of Shailabh's stove (well, i have
>>seen one, but not the other yet) and i have not had chance to look
>>at them yet. No need to rush, does it?
> 
> 
> Thursday's a long way off ;)
> 
> As long as we have a high level of confidence that any remaining issues
> will be fixed within a few weeks, this code is OK for a merge.
> 
> There's a general agreement that the kernel needs this feature - people
> have been mucking around with it for years.  Let's put the effort in and
> make it happen.

Yes, that is our intent! ;)

- jay


