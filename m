Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbUKJUXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUKJUXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUKJUXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:23:48 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44675 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262116AbUKJUVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:21:54 -0500
Message-ID: <41915992.30504@tmr.com>
Date: Tue, 09 Nov 2004 18:58:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Xen 2.0 Officially Released!
References: <E1CQ4uN-0004PN-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1CQ4uN-0004PN-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt wrote:
> The Xen team are pleased to announce the release of Xen 2.0, the
> open-source Virtual Machine Monitor.  Xen enables you to run
> multiple operating systems images concurrently on the same
> hardware, securely partitioning the resources of the machine
> between them. Xen uses a technique called 'para-virtualization'
> to achieve very low performance overhead -- typically just a few
> percent relative to native.  This new release provides kernel
> support for Linux 2.4.27/2.6.9 and NetBSD, with FreeBSD and Plan9
> to follow in the next few weeks.
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
> them. Visit the Xen homepage for downloads and documentation.
> 
> http://xen.sf.net

Looks like a fun thing to try on a new system as burn-in. I know openBSD 
better than OpenBSD, but that's not an issue for playing. There's 
another operating system I'd like to see supported, an obsolete old 
thing based on PC-DOS... The encapsulation doesn't have to work all that 
well, the original doesn't ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

