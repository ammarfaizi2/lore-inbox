Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWFNTSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWFNTSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWFNTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:18:12 -0400
Received: from cool.dworf.com ([193.189.190.81]:61780 "EHLO cool.dworf.com")
	by vger.kernel.org with ESMTP id S1750804AbWFNTSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:18:11 -0400
Message-ID: <449060EE.60608@dworf.com>
Date: Wed, 14 Jun 2006 21:18:06 +0200
From: David Osojnik <david@dworf.com>
Reply-To: david@dworf.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bad command responsiveness Proliant DL 585
References: <448FC1CE.9090108@dworf.com> <1150278161.7994.13.camel@Homer.TheSimpsons.net>
In-Reply-To: <1150278161.7994.13.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is the output of SysRq-T and SysRq-M:

http://www.dworf.com/sysrq.txt

any ideas?

thanks


Mike Galbraith wrote:
> Does top freeze if started from an mlockall(MCL_PRESENT|MCL_FUTURE)
> shell running at realtime priority?
>
> Try SysRq-T and SysRq-M during freezes to gather info about VM and task
> state during freeze.
>
> 	-Mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   
