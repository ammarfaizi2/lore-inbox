Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUBWBAQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUBWBAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:00:16 -0500
Received: from [216.127.68.117] ([216.127.68.117]:32458 "HELO 216.127.68.117")
	by vger.kernel.org with SMTP id S261302AbUBWBAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:00:10 -0500
Message-ID: <40395087.4010107@meerkatsoft.com>
Date: Mon, 23 Feb 2004 09:59:51 +0900
From: Alex <alex@meerkatsoft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Patch for ATI 9100 RS300
References: <403875CC.9010506@meerkatsoft.com> <200402221709.09245.MalteSch@gmx.de>
In-Reply-To: <200402221709.09245.MalteSch@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the graphics card workin but my problem is that I cannot set the DMA.
hdparm -d1 /dev/hda0 always gives me an error sayint this operation is 
not permitted.



Malte Schröder wrote:

>AFAIK the Radeon 9100 is the same as the 8500, at least I was able to use a 
>9100 BIOS on my 8500. The card ran without problems with XFree 4.3 .
>
>On Sunday 22 February 2004 10:26, Alex wrote:
>  
>
>>Hi,
>>I am trying to build a new Kernel (2.4.x) for my XPC ST61G4 which uses
>>the ATI Raedon 9100 RS300 Chipset.
>>Does anyone know if this chipset will be supported by Linux and where I
>>can find a Patch for it?
>>
>>Thanks
>>Alex
>>
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>  
>


