Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUH0Qcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUH0Qcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUH0Qcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:32:41 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60311 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266495AbUH0Qce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:32:34 -0400
Message-ID: <412F622D.5050404@sgi.com>
Date: Fri, 27 Aug 2004 11:32:45 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <20040827164548.A32422@infradead.org>
In-Reply-To: <20040827164548.A32422@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Aug 27, 2004 at 10:10:01AM -0500, Patrick Gefre wrote:
> 
>>This is an update to our last set of patches. I've added some comments from the
>>last review and another synopsis of the patches. The individual patches will
>>follow this email.
> 
> 
> Applying this against current BK gives a reject in
> arch/ia64/sn/io/machvec/pci_bus_cvlink.c for the 6th patch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I used the tree at http://lia64.bkbits.net/linux-ia64-test-2.6.8.1
from yesterday
