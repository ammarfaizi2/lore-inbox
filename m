Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVBGR3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVBGR3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVBGR3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:29:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16030 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261213AbVBGR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:28:07 -0500
Message-ID: <4207A513.10601@pobox.com>
Date: Mon, 07 Feb 2005 12:27:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Mathias Kretschmer <posting@blx4.net>, linux-kernel@vger.kernel.org
Subject: Re: VIA VT6410 IDE support for 2.6.11-rc3/via82cxxx
References: <41A2E581.2010305@blx4.net> <41A38128.90305@pobox.com> <41A3A238.3070003@blx4.net> <4206A1F5.6050305@blx4.net> <4207A268.3040804@blx4.net>
In-Reply-To: <4207A268.3040804@blx4.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Kretschmer wrote:
> Mathias Kretschmer wrote:
> 
>> Mathias Kretschmer wrote:
>>
>>> Jeff Garzik wrote:
>>>
>>>> Mathias Kretschmer wrote:
>>>>
>>>>> hi,
>>>>>
>>>>> I found an older version of this patch (against 2.4.22) on some 
>>>>> website. After a little bit of editing it applied cleanly to 2.4.27 
>>>>> (and now 2.4.28). It works fine for me on a ASUS P4P800-Deluxe with 
>>>>> 4x 300GB disks.
>>>>>
>>>>> Maybe someone finds this patch helpful. Any reason why the original 
>>>>> patch did not make it into the kernel ?
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> Why not add it to the existing via82cxxx driver, and get better 
>>>> performance and device tuning?
>>
>>
>>
>> OK, the attached patch adds support for the VIA 6410 chip to the 
>> via82cxxx driver (instead of the generic driver).
>> I've tested it on the board mentioned above. Works fine for me.
>>
>> Cheers,
>>
>> Mathias
> 
> 
> as above, but for 2.6.11-rc3


Bart, got this one?

	Jeff


