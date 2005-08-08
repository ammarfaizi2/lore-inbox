Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVHHSNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVHHSNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVHHSNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:13:21 -0400
Received: from hermes.domdv.de ([193.102.202.1]:17160 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932171AbVHHSNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:13:20 -0400
Message-ID: <42F7A0AF.8070202@domdv.de>
Date: Mon, 08 Aug 2005 20:13:03 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Lee Revell <rlrevell@joe-job.com>, Denis Vlasenko <vda@ilport.com.ua>,
       abonilla@linuxwireless.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wireless support
References: <1123442554.12766.17.camel@mindpipe>	 <1123461574.4920.6.camel@localhost.localdomain>	 <200508080931.59084.vda@ilport.com.ua> <1123523298.15269.18.camel@mindpipe> <1123523476.3245.51.camel@laptopd505.fenrus.org>
In-Reply-To: <1123523476.3245.51.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2005-08-08 at 13:48 -0400, Lee Revell wrote:
> 
>>On Mon, 2005-08-08 at 09:31 +0300, Denis Vlasenko wrote:
>>
>>>On Monday 08 August 2005 03:39, Alejandro Bonilla Beeche wrote:
>>>
>>>>On Sun, 2005-08-07 at 15:22 -0400, Lee Revell wrote:
>>>>
>>>>>Is the Linksys WUSB 54GS wireless adapter (FCCID Q87-WUSB54GS)
>>>>>supported?
>>>>
>>>>Normally, linksys doesn't care much about Linux and they won't even
>>>>release info for a driver. Yeah, they have some open info for the WRT's
>>>>but the adapters are normally usable with ndiswrapper or Linuxant
>>>>driver.
>>>
>>>The more I read this, the more I think about usefulness of blacklisting
>>>ndiswrapper.
>>
>>What's your reasoning?  The technical aspect of the argument is obvious
>>(incompatible with 4K stacks) but the political side seems insolvable.
>>Wouldn't this leave thousands of users with non working hardware?\
> 
> 
> arguably it doesn't really work with ndiswrapper either; only most of
> the time (due to windows having a 12kb stack)... and it's effectively a
> binary only kernel module.
> 
> it also provides a discentive for vendors to provide real linux
> drivers....
> 

Oh well,
I gave up on my laptop's built in Inprocomm IPN 2220 quite some time ago
(one more reason not to like Cisco). In the rare cases I do really need
wlan there is http://zd1211.sourceforge.net/

You can get it to work on x86_64. It currently has no wpa but I don't
care, IPSec is a proven solution. The code looks ugly but time will show
how it evolves. And about 40 EUR for the Longshine LCS-8170 802.11b/g
and Bluetooth 1.2 combo adapter isn't really expensive. The only
drawback is that it is another piece of external hardware to carry
around as well as some more laptop built in crap.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
