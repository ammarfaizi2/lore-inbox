Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTAXUzx>; Fri, 24 Jan 2003 15:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAXUzx>; Fri, 24 Jan 2003 15:55:53 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:33124
	"EHLO bluetooth.WNI.AD") by vger.kernel.org with ESMTP
	id <S265373AbTAXUzv>; Fri, 24 Jan 2003 15:55:51 -0500
Message-ID: <3E31AB26.5080508@WirelessNetworksInc.com>
Date: Fri, 24 Jan 2003 14:07:50 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: AnonimoVeneziano <voloterreno@tin.it>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it> <3E3199FF.3090000@tin.it>
In-Reply-To: <3E3199FF.3090000@tin.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 21:05:04.0516 (UTC) FILETIME=[44497C40:01C2C3EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is a hardware 'feature', but nothing to worry about.  The software 
just has to live with it.  This problem is as old as the PC itself, 
dating back to the original IBM design from 1981.

Cheers,
-- 
Herman Oosthuysen
B.Eng (E), Member of IEEE
Aerospace Software Ltd
http://www.AerospaceSoftware.com
Phone: 1.403.852-5545, Fax: 1.403.241-8841
E-mail: Herman@AerospaceSoftware.com
E-mail: Herman@ARMdimension.com


AnonimoVeneziano wrote:
> I've noticed also that the number indicated by the ERR field in 
> /proc/interrupts increase slowly with the time.
> But, at the end of all I haven't understood well what is this error, and 
> what the ERR field indicates. And why with IO-APIC it disappears? 
> (IO-APIC gives me very much problems with ACPI :-( )
> 
> Bye
> 
> 
> AnonimoVeneziano wrote:
> 
>> What does it mean this message?
>>
>> Of what problem is the signal?
>> There is a way to solve this? (Next kernel versions) or is an HW 
>> problem? (Motherboard MSI KT7 Ultra)
>>
>> Thanks
>>
>> Bye
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

