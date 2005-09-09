Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVIIQ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVIIQ5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVIIQ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:57:52 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:61397 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S1030233AbVIIQ5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:57:51 -0400
Message-ID: <4321BF0C.2000007@candelatech.com>
Date: Fri, 09 Sep 2005 09:57:48 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Physical device to Kernel-netlink mapper
References: <200509091538.27605.a1426z@gawab.com>
In-Reply-To: <200509091538.27605.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Is there a virtual device that would allow to connect the communication paths 
> from the physical devs into the kernel netlink subsystem in a way that would 
> be more flexible than what is currently avaible?
> 
> Something like this:
> 
>     Kernel-netlink
>         |
>     virtual dev
>         |
> --> mapper/conf <--
>         |
>     physical dev(s)
> 
> tun/tap,bridge,bond... are devs that incorporate this idea, but don't allow 
> for a flexible configuration.

I have some other types of virtual (ethernet-ish) interfaces, but I have
no idea what you are really asking....

Please explain in more detail.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

