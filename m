Return-Path: <linux-kernel-owner+w=401wt.eu-S1752886AbXACBZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbXACBZI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbXACBZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:25:08 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:34724 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbXACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:25:06 -0500
In-Reply-To: <000e01c72ed5$bcbb9430$ff0da8c0@amr.corp.intel.com>
References: <000e01c72ed5$bcbb9430$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0918A75D-9007-4697-BBC3-95DD07CA9881@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: make aio_ring_info->nr_pages an unsigned int
Date: Tue, 2 Jan 2007 17:25:05 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I had that changes earlier, but dropped it to make the patch smaller.

Still have it kicking around?

Making this stuff more consistent would be nice, I agree, I'm just  
not sure it's worth the risk of running into some subtle bugs.

- z
