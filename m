Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbULNNE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbULNNE2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbULNNE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:04:28 -0500
Received: from smtp05.web.de ([217.72.192.209]:64747 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S261496AbULNND3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:03:29 -0500
Message-ID: <41BEE49E.8060002@web.de>
Date: Tue, 14 Dec 2004 13:03:26 +0000
From: Felix Dorner <felix_do@web.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: internal card reader support
References: <41B74174.3080908@web.de> <41B75454.3060301@cantab.net>
In-Reply-To: <41B75454.3060301@cantab.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Vrabel wrote:

> Felix Dorner wrote:
>
>>
>> 0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 
>> (rev 01)
>> 0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 
>> (rev 01)
>> 0000:02:04.2 System peripheral: Texas Instruments: Unknown device 
>> 8201 (rev 01)
>
>
> This is a TI PCI1620.  You can get data sheets etc. from TI's website. 
> Not sure how much good that will do you though as it appears to 
> require firmware -- the 3rd function is a firmware loader interface.
>
> David Vrabel

First thanks for that. And i am courious: You get that just from the 
lspci output? Do you know this chip?

Where can I dive deeply into PCI Bus technology? We just played with 
small microcontrollers connected to three pushbuttons at University...

Felix
