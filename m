Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUASV6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUASV6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:58:23 -0500
Received: from ms-smtp-03-lbl.southeast.rr.com ([24.25.9.102]:59571 "EHLO
	ms-smtp-03-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S262652AbUASV6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:58:17 -0500
Message-ID: <400C5326.8070500@us.ibm.com>
Date: Mon, 19 Jan 2004 16:59:02 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] IBM PowerPC Virtual Ethernet Driver
References: <400C3CEA.1060004@us.ibm.com> <20040119205629.A5831@infradead.org>
In-Reply-To: <20040119205629.A5831@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>>http://www-124.ibm.com/linux/patches/ppc64/ibmveth.patch
>>
>>The patch applies against the 2.4.25-pre6 tree...
> 
> 
> Usually patches are subitted inline to ease review..
> 

That was my original intention, however section 4, question 1 in the FAQ 
states:
"If your patch is on the large size (say larger than 500 lines) consider 
posting a URL pointing to the patch along with the patch description, 
instead of the whole patch."
This patch was 1300+ lines.

> I think we shouldn't accept new drivers in 2.4 anymore unless they're
> already in 2.6

Sure, it makes sense... I just wanted to get this driver out since the 
2.4 tree has some architectural features that 2.6 doesn't have yet... 
I'm not sure how those features made it to 2.4 before 2.6 though!...

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center
