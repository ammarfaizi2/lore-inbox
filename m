Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVC3Bts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVC3Bts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVC3Btf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:49:35 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:54173 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261709AbVC3Bt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:49:27 -0500
In-Reply-To: <1112139564.31848.65.camel@gaston>
References: <1111966920.5409.27.camel@gaston> <1112067369.19014.24.camel@mindpipe> <4a7a16914e8d838e501b78b5be801eca@dalecki.de> <1112084311.5353.6.camel@gaston> <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de> <1112134385.5386.22.camel@mindpipe>  <4249E3F4.8070005@nortel.com> <1112139564.31848.65.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3437534780e9f73588875e8964bac2ed@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Chris Friesen <cfriesen@nortel.com>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Mac mini sound woes
Date: Wed, 30 Mar 2005 03:48:57 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-30, at 01:39, Benjamin Herrenschmidt wrote:

> On Tue, 2005-03-29 at 17:25 -0600, Chris Friesen wrote:
>> Lee Revell wrote:
>>
>>> This is the exact line of reasoning that led to Winmodems.
>>
>> My main issue with winmodems is not so much the software offload, but
>> rather that the vendors don't release full specs.
>>
>> If all winmodem manufacturers released full hardware specs, I doubt
>> people would really complain all that much.  There's a fairly large 
>> pool
>> of talent available to write drivers once the interfaces are known.
>
> Look at the pile of junk that are most winmodem driver implementations,
> nothing I want to see in the kernel ever. Those things should be in
> userland.

You are joking? Linux IS NOT an RT OS. And well not too long ago you 
could
be jailed for example in germany for using not well behaving 
communication devices.

