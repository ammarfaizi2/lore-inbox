Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVCBQRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVCBQRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVCBQRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:17:22 -0500
Received: from cibs10.sns.it ([192.167.206.30]:58807 "EHLO reed.sns.it")
	by vger.kernel.org with ESMTP id S262347AbVCBQRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:17:00 -0500
Date: Wed, 2 Mar 2005 17:16:52 +0100 (CET)
From: venom@sns.it
To: Ben Greear <greearb@candelatech.com>
cc: Lee Revell <rlrevell@joe-job.com>, linux-os@analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10
In-Reply-To: <4224D0F5.4050400@candelatech.com>
Message-ID: <Pine.LNX.4.62.0503021715370.15839@Expansa.sns.it>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com> 
 <4224CE98.2060204@candelatech.com> <1109708691.14272.8.camel@mindpipe>
 <4224D0F5.4050400@candelatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not the e100 driver, but some switch, (e.g. some matrix) has a buggy 
autonegotiation.

On Tue, 1 Mar 2005, Ben Greear wrote:

> Lee Revell wrote:
>> On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
>> 
>>> What happens if you just don't muck with the NIC and let it auto-negotiate
>>> on it's own?
>> 
>> 
>> This can be asking for trouble too (auto negotiation is often buggy).
>> What if you hard set them both to 100/full?
>
> I have not noticed any buggy autonegotiation with the e100 driver in several
> years...
>
> Ben
>
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
