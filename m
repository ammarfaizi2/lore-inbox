Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280101AbRK0PJg>; Tue, 27 Nov 2001 10:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280133AbRK0PJY>; Tue, 27 Nov 2001 10:09:24 -0500
Received: from hermes.domdv.de ([193.102.202.1]:47369 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S280798AbRK0PIQ>;
	Tue, 27 Nov 2001 10:08:16 -0500
Message-ID: <XFMail.20011127160456.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E168jk1-0001J7-00@the-village.bc.nu>
Date: Tue, 27 Nov 2001 16:04:56 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 'spurious 8259A interrupt: IRQ7'
Cc: linux-kernel@vger.kernel.org, lkml@patrickburleson.com,
        <martin@jtrix.com (Martin A. Brooks)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27-Nov-2001 Alan Cox wrote:
>> > Something I should have added to my post is that I have a Tulip based
>> > NIC  from Netgear.  But I believe something is definitely amiss with
>> > Athlon based  machines and Tulip cards and compiled in SMP support.
>> 
>> Mine is a UP box.
> 
> With IO Apic support included ? If you are using an AMD/VIA combo chipset
> board that would explain it

IO Apic, yes. But the PII/PIII systems are BX or I810/I815.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
