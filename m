Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVCIVYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVCIVYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVCIVYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:24:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:11474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261589AbVCIVVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:21:39 -0500
Message-ID: <422F68E0.90607@osdl.org>
Date: Wed, 09 Mar 2005 13:21:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
References: <20050309083923.GA20461@kroah.com> <20050309210631.GY3163@waste.org>
In-Reply-To: <20050309210631.GY3163@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Mar 09, 2005 at 12:39:23AM -0800, Greg KH wrote:
> 
>>And to further test this whole -stable system, I've released 2.6.11.2.
>>It contains one patch, which is already in the -bk tree, and came from
>>the security team (hence the lack of the longer review cycle).
>>
>>It's available now in the normal kernel.org places:
>>	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
>>which is a patch against the 2.6.11.1 release.
> 
> 
> Argh! @*#$&!!&! 

I have to Argh this also (with Matt).


>>If consensus arrives
>>that this patch should be against the 2.6.11 tree, it will be done that
>>way in the future.

It would be much easier on users/testers to have to apply
only one patch to base (2.6.11 e.g.) to get to 2.6.x.y
(2.6.11.3 e.g.).  One Patch File.  Not three.

> Consensus arrived back when 2.6.8.1 came out.
> 
> Please, folks, there are automated tools that "know" about kernel
> release numbering and so on. Said tools broke with 2.6.11.1 because it
> wasn't in the same place that 2.6.8.1 was and now this breaks with all
> precedent by being an interdiff along a branch.
> 
> Fixing it in the future is too #*$%* late because you've now turned it
> into a special case.


-- 
~Randy
