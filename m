Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVCBQOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVCBQOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVCBQOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:14:47 -0500
Received: from cibs10.sns.it ([192.167.206.30]:4791 "EHLO reed.sns.it")
	by vger.kernel.org with ESMTP id S262338AbVCBQOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:14:45 -0500
Date: Wed, 2 Mar 2005 17:14:32 +0100 (CET)
From: venom@sns.it
To: Lee Revell <rlrevell@joe-job.com>
cc: Ben Greear <greearb@candelatech.com>, linux-os@analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10
In-Reply-To: <1109708691.14272.8.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0503021711440.15839@Expansa.sns.it>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com> 
 <4224CE98.2060204@candelatech.com> <1109708691.14272.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if switch ports are configured as 100FDX auto=off or
100HDX auto=off.
from the report I saw it seems that switch ports are 100HDX auto=off 
instead of 100FDX auto=off.

On Tue, 1 Mar 2005, Lee Revell wrote:

> On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
>> What happens if you just don't muck with the NIC and let it auto-negotiate
>> on it's own?
>
> This can be asking for trouble too (auto negotiation is often buggy).
> What if you hard set them both to 100/full?
>
> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
