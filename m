Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTAXTm6>; Fri, 24 Jan 2003 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTAXTm6>; Fri, 24 Jan 2003 14:42:58 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:58359 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S264857AbTAXTm4>;
	Fri, 24 Jan 2003 14:42:56 -0500
Message-ID: <3E3199FF.3090000@tin.it>
Date: Fri, 24 Jan 2003 20:54:39 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it>
In-Reply-To: <3E2C8EFF.6020707@tin.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed also that the number indicated by the ERR field in 
/proc/interrupts increase slowly with the time.
But, at the end of all I haven't understood well what is this error, and 
what the ERR field indicates. And why with IO-APIC it disappears? 
(IO-APIC gives me very much problems with ACPI :-( )

Bye


AnonimoVeneziano wrote:

> What does it mean this message?
>
> Of what problem is the signal?
> There is a way to solve this? (Next kernel versions) or is an HW 
> problem? (Motherboard MSI KT7 Ultra)
>
> Thanks
>
> Bye
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


