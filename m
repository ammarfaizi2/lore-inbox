Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVI2Sdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVI2Sdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVI2Sdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:33:52 -0400
Received: from lucidpixels.com ([66.45.37.187]:28109 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932493AbVI2Sdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:33:51 -0400
Date: Thu, 29 Sep 2005 14:33:50 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Nuno Silva <nuno.silva@vgertech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
In-Reply-To: <433C31C8.1030901@vgertech.com>
Message-ID: <Pine.LNX.4.63.0509291433340.13272@p34>
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will have to give this a shot, any idea when it will be merged into 
mainline?

Thanks,

Justin.

On Thu, 29 Sep 2005, Nuno Silva wrote:

> Justin Piszcz wrote:
>> Under 2.6.13.2,
>> 
>> Is there any utility that I can use to put a SATA HDD to sleep?
>> Secondly, I notice I cannot access any of the HDD's S.M.A.R.T. functions on 
>> SATA drives?
>
> Search for Jeff's patch 2.6.12-git4-passthru1.patch
> I think this will be included RSN. This solves your two issues.
>
> Regards,
> Nuno Silva
>
