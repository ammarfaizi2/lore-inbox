Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVAQL7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVAQL7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 06:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVAQL7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 06:59:30 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:34738 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262778AbVAQL70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 06:59:26 -0500
Message-ID: <41EBA8AD.3060302@drzeus.cx>
Date: Mon, 17 Jan 2005 12:59:41 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com> <41EA5C8D.8070407@drzeus.cx> <41EA69F0.5060500@f2s.com> <41EAC3FD.1070001@drzeus.cx> <047701c4fc21$a1579b50$0f01a8c0@max> <41EB5610.1080708@drzeus.cx> <00d501c4fc7a$76ef9940$0f01a8c0@max>
In-Reply-To: <00d501c4fc7a$76ef9940$0f01a8c0@max>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:

> Pierre Ossman:
>
>> I, personally, would really like to see SD support included in the 
>> main kernel. But I can also fully understand if that's not currently 
>> possible.
>
> I think the way forward is for someone to propose a patch. Your code 
> sounds the most advanced but Ian or myself may be prepared to propose 
> something if you don't want to. A decision can then be made about 
> whether it can be accepted. There have been no objections raised so 
> far - just words of caution.

I have no problem with proposing my patch. The reason I've been waiting 
is that I got information from Jim Getttys (of HP) that the SD spec. 
would be made public very soon. So I was waiting for it to be released 
so that we could avoid the legal discussion completely. This was in 
october though and I haven't been able to reach him for an update. So 
perhaps it's time to try a submission notetheless.

What is Russell's position on this issue? After all the MMC layer is his 
baby ;)

Rgds
Pierre

