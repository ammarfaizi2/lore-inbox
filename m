Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVCMQ2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVCMQ2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVCMQ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:28:03 -0500
Received: from smtpout.mac.com ([17.250.248.46]:42744 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261346AbVCMQ17 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:27:59 -0500
In-Reply-To: <200503112110.28060.lists@kenneth.aafloy.net>
References: <20050311125836.BDB721B02B@nx-01.home.sapienti-sat.org> <200503112110.28060.lists@kenneth.aafloy.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <62c8caa22a30effe558123947ae8caeb@mac.com>
Content-Transfer-Encoding: 8BIT
Cc: Juri Haberland <juri@koschikode.com>, linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Subject: Re: linux dvb alps_tdlb7 removed
Date: Sun, 13 Mar 2005 16:43:39 +0100
To: =?ISO-8859-1?Q?Kenneth_Aafl=F8y?= <lists@kenneth.aafloy.net>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 11.03.2005 um 21:10 schrieb Kenneth Aafløy:

> On Friday 11 March 2005 13:58, Juri Haberland wrote:
>> In article <aebc44b2e0c42cc9dc0ec0b215c10ec4@mac.com> you wrote:
>>> With version 2.6.10 the driver for the tuner frontend from ALPS TDLB7
>>> was removed.
>>>
>>> Why do you think that this is a dead file?
>>> While I'm happy with the work you do for dvb on Linux, and I want to
>>> thank you for this anyway, my TV does not work anymore! :(
>>>
>>> I use a TechoTrend Premium card with that frontend on it. It worked
>>> fine until 2.6.10.
>>> Can you put it back into mainline? Is there some work to do for
>>> reinsertion?
>>
>> I think the driver you now need is sp8870. It's just another name for
>
> Yup you are right. If someone has a card that is no longer working,
> please have a look at these pages and contact the linuxtv-dvb 
> mailing-list:
>
> http://www.linuxtv.org/wiki/index.php/Supported_DVB_cards
> http://www.linuxtv.org/wiki/index.php/DVB_cards_requiring_definition
> http://www.linuxtv.org/lists.php

Thanx, now it works again under 2.6.11
I had to create a link in /usr/lib/hotplug/firmware with the new name 
also.

	Peter

