Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbTH0JeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTH0JeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:34:05 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:15752 "EHLO
	boszi-lnx.localdomain") by vger.kernel.org with ESMTP
	id S263198AbTH0JeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:34:01 -0400
Message-ID: <3F4C7AFA.4070906@freemail.hu>
Date: Wed, 27 Aug 2003 11:33:46 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: How to use an USB<->serial adapter?
References: <3F44BEA2.8010108@freemail.hu> <1061507883.8723.45.camel@sonja>	 <3F49AB95.7090105@freemail.hu> <1061806775.741.19.camel@sonja>
In-Reply-To: <1061806775.741.19.camel@sonja>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> Am Mon, 2003-08-25 um 08.24 schrieb Boszormenyi Zoltan:
> 
> 
>>What product is this? Mine is a Wiretek UN8BE, based on Prolific 2303.
> 
> 
> Mine is from STLAB.
> ...
> 
>>In the shop they said this one cannot be used as a null-link but works
>>with external serial devices, e.g. modems. I have yet to verify this
>>statement myself.
> 
> 
> Doesn't really make sense to me. RS232 is specified electrically, the
> adapter doesn't know which kind of device it is talking to. I'm using
> mine to connect to a TTL-RS232 adapter which sits on a DSL-router, so
> it's like a "null-link".

Now, I was able to get an external modem. No workee...
The modem RD/TD LEDs are flashing, DTR is lit on permanently
so the modem is receiving and *tries to send*. Maybe the shop
went this far in testing to say that the cable works. :-(
But the PC isn't receiving. E.g. in WinXX, the modem is not found,
in RH9, no dialing out.

At least it is consistent with my findings with the null-link cable.
Back to the shop and sorry for the noise.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

