Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUKRVkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUKRVkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUKRViZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:38:25 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44181 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263036AbUKRVhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:37:46 -0500
Message-ID: <419D1612.4000702@tmr.com>
Date: Thu, 18 Nov 2004 16:37:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
CC: linux-kernel@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Steven.Hand@cl.cam.ac.uk
Subject: Re: Xen 2.0 VMM patches
References: <E1CUZSs-000502-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1CUZSs-000502-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt wrote:

> Original Xen 2.0 release annoucement:
> 
> The Xen team are pleased to announce the release of Xen 2.0, the
> open-source Virtual Machine Monitor.  Xen enables you to run
> multiple operating systems images concurrently on the same
> hardware, securely partitioning the resources of the machine
> between them. Xen uses a technique called 'para-virtualization'
> to achieve very low performance overhead -- typically just a few

I wasn't about to mention this, but since you reposted it I will. I 
shared the original post with a number of people and at least three 
mentioned it.

The term "low performance overhead" just seems to make people thinks 
it's slow, and they don't read past it. I highly suggest either "low 
overhead" or "low performance impact" would avoid this.

Perhaps I just know a lot of other people who suffer from literalism.

> percent relative to native.  This new release provides kernel
> support for Linux 2.4.27/2.6.9, NetBSD and FreeBSD.
> 
> Xen 2.0 runs on almost the entire set of modern x86 hardware
> supported by Linux, and is easy to 'drop-in' to an existing Linux
> installation.  The new release has a lot more flexibility in how
> guest OS virtual I/O devices are configured. For example, you can
> configure arbitrary firewalling, bridging and routing of guest
> virtual network interfaces, and use copy-on-write LVM volumes or
> loopback files for storing guest OS disk images.  Another new
> feature is 'live migration', which allows running OS images to be
> moved between nodes in a cluster without having to stop
> them. Visit http://xen.sf.net for downloads and documentation.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
