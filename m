Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbVK3RgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVK3RgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVK3RgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:36:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:7825 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751471AbVK3RgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:36:12 -0500
Date: Wed, 30 Nov 2005 18:35:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn?= <carlosmn@gmail.com>
cc: JaniD++ <djani22@dynamicweb.hu>, linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
In-Reply-To: <fe726f4e0511290736w6931ec83q@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511301835270.26040@yvahk01.tjqt.qr>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz> 
 <Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr>  <018c01c5f435$9e548370$0400a8c0@dcccs>
  <200511291015.55181.vda@ilport.com.ua> <fe726f4e0511290736w6931ec83q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > *7)
>> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
>> > *7)
>> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3
>> > 4 5 6 7 10 11 12 14 15) *0, disabled.
>> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3
>> > 4 5 6 7 10 11 12 14 15) *0, disabled.
>> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3
>> > 4 5 6 7 10 11 12 14 15) *0, disabled.
>> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3
>> > 4 5 6 7 *10 11 12 14 15)
>> >
>> > This is normal?  :-)
>>
>> I do not understand your question
>
>To answer the question, yes, it is perfectly normal to see that.
>That's just the kernel describing how the PCI IRQs are set up. You
>have nothing to worry about.

I think it's the "disabled" that worries.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
