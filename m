Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbULNNYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbULNNYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULNNYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:24:22 -0500
Received: from webapps.arcom.com ([194.200.159.168]:28933 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261493AbULNNYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:24:18 -0500
Message-ID: <41BEE981.6030904@davidvrabel.org.uk>
Date: Tue, 14 Dec 2004 13:24:17 +0000
From: David Vrabel <david@davidvrabel.org.uk>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix Dorner <felix_do@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: internal card reader support
References: <41B74174.3080908@web.de> <41B75454.3060301@cantab.net> <41BEE49E.8060002@web.de>
In-Reply-To: <41BEE49E.8060002@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2004 13:26:41.0140 (UTC) FILETIME=[8C06DB40:01C4E1E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Dorner wrote:
> David Vrabel wrote:
> 
>> Felix Dorner wrote:
>>
>>>
>>> 0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 
>>> (rev 01)
>>> 0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 
>>> (rev 01)
>>> 0000:02:04.2 System peripheral: Texas Instruments: Unknown device 
>>> 8201 (rev 01)
>>
>> This is a TI PCI1620.  [...]
> 
> First thanks for that. And i am courious: You get that just from the 
> lspci output? Do you know this chip?

I'm familiar with another chip in the same family (one with only 
PCMCIA/CardBus support so I can't help you with the flash card parts) so 
I just did a quick scan of TI's website.  The ac54 is the device ID for 
the part which you find in datasheets and the like.

David Vrabel
