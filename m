Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVK2Pgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVK2Pgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVK2Pgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:36:51 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:11460 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751381AbVK2Pgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:36:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6XVPPsybF+Q71EdKfmlmoMJrSJcijASZPk8r3qtCRb6/iDz0PhQL3EpHx2c1JQvEUEsszAaZaf3HN5bwyC376VR4mFrcQRX78FGzopeorYeP6wPq5i1W8yNYFPUoy2eVVW6nFstoq4fwrHewRUxqIbUY/Z9zDXFOOMF+QFaVg4=
Message-ID: <fe726f4e0511290736w6931ec83q@mail.gmail.com>
Date: Tue, 29 Nov 2005 16:36:49 +0100
From: =?ISO-8859-1?Q?Carlos_Mart=EDn?= <carlosmn@gmail.com>
To: JaniD++ <djani22@dynamicweb.hu>
Subject: Re: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
Cc: linux-kernel@vger.kernel.org, Denis Vlasenko <vda@ilport.com.ua>
In-Reply-To: <200511291015.55181.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
	 <Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr>
	 <018c01c5f435$9e548370$0400a8c0@dcccs>
	 <200511291015.55181.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Monday 28 November 2005 18:05, JaniD++ wrote:
> >References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz> <43892897.9020900@vc.cvut.cz> <Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr>
>
> You abuse your reply button
>
> >X-Mailer: Microsoft Outlook Express 6.00.2800.1437
> >X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
>
> No wonder...

Hey, MS bashing! Can I join in?
Now, wouldn't it be sacrilege to post to any technical list with
something like Outlook?
>
> > Hi,
> >
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs
> > *7)
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs
> > *7)
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs
> > *7)
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs
> > *7)
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3
> > 4 5 6 7 10 11 12 14 15) *0, disabled.
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3
> > 4 5 6 7 10 11 12 14 15) *0, disabled.
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3
> > 4 5 6 7 10 11 12 14 15) *0, disabled.
> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3
> > 4 5 6 7 *10 11 12 14 15)
> >
> > This is normal?  :-)
>
> I do not understand your question

That's output from the kernel bootup-sequence, he's seen it and is
asking if that is normal behavior/output.

To answer the question, yes, it is perfectly normal to see that.
That's just the kernel describing how the PCI IRQs are set up. You
have nothing to worry about.

   cmn
--
Carlos Martín Nieto        http://www.cmartin.tk

"¿Cómo voy a decir bobadas si soy mudo?" -- CACHAI
