Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTEAO51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTEAO51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:57:27 -0400
Received: from fep01.superonline.com ([212.252.122.40]:14239 "EHLO
	fep01.superonline.com") by vger.kernel.org with ESMTP
	id S261336AbTEAO5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:57:18 -0400
Message-ID: <3EB1389C.7050109@superonline.com>
Date: Thu, 01 May 2003 18:09:16 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Thomas Backlund <tmb@iki.fi>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
References: <3EB12D42.4010502@superonline.com> <200305011803.22048.tmb@iki.fi>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=iso-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You cann see that in my logfiles (in the archived messages in MARC I
had referenced).

Regards;
Özkan Sezer



Thomas Backlund wrote:
> Viestissä Torstai 1. Toukokuuta 2003 17:20, O.Sezer kirjoitti:
> 
>>Thomas Backlund wrote:
>>
>>[SNIPPED]
>>
>> > So this way we wont break current systems,
>> > but have an option for those cards that has problem...
>> > (seems to be AGP + >=128MB VideoRAM + >=1024MB system RAM only)
>>
>>AGP			-> Yes
>>
>> >= 128MB RAM		-> Yes
>> >=1024MB system RAM	-> _ NO _.  Only 256MB
>>
> 
> Now thats new to me...
> all reports I've seen earlier has been with 1024MB or more...
> Oh well... every day you learn something new...
> 
> 
>>>(OK, I added another 128 today, so it's 384 now :))
>>
>>Regards;
>>Özkan Sezer
> 
> 

