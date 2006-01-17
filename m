Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWAQXNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWAQXNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWAQXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:13:00 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:47110 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S964883AbWAQXM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:12:59 -0500
In-Reply-To: <20060117.150528.108145661.davem@davemloft.net>
References: <26F1D638-7A96-48C6-9191-74363C497820@kernel.crashing.org> <20060117.150528.108145661.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6BA104E8-618F-4938-A714-53B5FD9FDA0B@kernel.crashing.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: NIP6_FMT "breaks" ifconfig
Date: Tue, 17 Jan 2006 17:12:53 -0600
To: "David S. Miller" <davem@davemloft.net>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 17, 2006, at 5:05 PM, David S. Miller wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Tue, 17 Jan 2006 16:35:01 -0600
>
>> The use of NIP6_FMT from kernel.h in net/ipv6/addrconf.c changes  
>> how /
>> proc/net/if_inet6 format's IPv6 addresses and thus breaks ifconfig's
>> ability to display IPv6 addresses.  I'm not sure if this is
>> acceptable breakage of a userspace app or not.
>
> I know, I have a fix from Yoshifuji in my tree and I'll
> make sure Linus gets it.

Cool.

thanks

- k
