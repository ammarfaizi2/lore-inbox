Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVK3Xaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVK3Xaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVK3Xav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:30:51 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:53940 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751200AbVK3Xav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:30:51 -0500
Message-ID: <042001c5f605$6bd5cbd0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn?= <carlosmn@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz> <Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr> <018c01c5f435$9e548370$0400a8c0@dcccs> <200511291015.55181.vda@ilport.com.ua> <fe726f4e0511290736w6931ec83q@mail.gmail.com>
Subject: Re: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
Date: Thu, 1 Dec 2005 00:18:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


----- Original Message ----- 
From: "Carlos Martín" <carlosmn@gmail.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>; "Denis Vlasenko" <vda@ilport.com.ua>
Sent: Tuesday, November 29, 2005 4:36 PM
Subject: Re: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)


> On 29/11/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> > On Monday 28 November 2005 18:05, JaniD++ wrote:
> > >References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
<43892897.9020900@vc.cvut.cz>
<Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr>
> >
> > You abuse your reply button
> >
> > >X-Mailer: Microsoft Outlook Express 6.00.2800.1437
> > >X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
> >
> > No wonder...
>
> Hey, MS bashing! Can I join in?
> Now, wouldn't it be sacrilege to post to any technical list with
> something like Outlook?

Sorry, i hate M$ generally, but.... :-P
(....i like outlook....
this is the one exception.)


> >
> > > Hi,
> > >
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKA]
(IRQs
> > > *7)
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKB]
(IRQs
> > > *7)
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKC]
(IRQs
> > > *7)
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKD]
(IRQs
> > > *7)
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKE]
(IRQs 3
> > > 4 5 6 7 10 11 12 14 15) *0, disabled.
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKF]
(IRQs 3
> > > 4 5 6 7 10 11 12 14 15) *0, disabled.
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKG]
(IRQs 3
> > > 4 5 6 7 10 11 12 14 15) *0, disabled.
> > > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKH]
(IRQs 3
> > > 4 5 6 7 *10 11 12 14 15)
> > >
> > > This is normal?  :-)
> >
> > I do not understand your question
>
> That's output from the kernel bootup-sequence, he's seen it and is
> asking if that is normal behavior/output.
>
> To answer the question, yes, it is perfectly normal to see that.
> That's just the kernel describing how the PCI IRQs are set up. You
> have nothing to worry about.

Thanks for the answer!
I ask that because i newer seen this format befor: "[LNKA] (IRQs *7)"

Thanks
Janos


>
>    cmn
> --
> Carlos Martín Nieto        http://www.cmartin.tk
>
> "¿Cómo voy a decir bobadas si soy mudo?" -- CACHAI
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

