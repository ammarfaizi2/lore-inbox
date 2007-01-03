Return-Path: <linux-kernel-owner+w=401wt.eu-S1753552AbXACCHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbXACCHz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbXACCHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:07:55 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:49493 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbXACCHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:07:54 -0500
In-Reply-To: <001001c72eda$f892b1a0$ff0da8c0@amr.corp.intel.com>
References: <001001c72eda$f892b1a0$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3902D76A-A36E-4B27-A6B4-487B148FF2A7@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: streamline read events after woken up
Date: Tue, 2 Jan 2007 18:07:52 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> buffer index there.  By then, most of you would probably veto the
> patch anyway ;-)

haha, touche :)

I still think it'd be the right thing, though.  We can let the patch  
speak for itself :).

- z
