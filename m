Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUBEQnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266497AbUBEQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:43:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:7344 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266495AbUBEQnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:43:50 -0500
Date: Thu, 5 Feb 2004 17:43:49 +0100 (MET)
From: "Roman Jordan" <RomanJordan@gmx.de>
To: Ludootje <ludootje@linux.be>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <1076002007.4190.14.camel@gax.mynet>
Subject: Re: questin about switch off
X-Priority: 3 (Normal)
X-Authenticated: #532004
Message-ID: <28819.1075999429@www62.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
i have configured the kernel using ACPI not APM. I will try APM today
evening.
The older kernel works only if i terminate the linux session from running X
(using menu).

Thanks,
Roman

> IIRC that had something with using or APM (Advanced Power
> Management) or not. I think that if you enable it in the kernel,
> halt/poweroff/shutdown will work fine.
> 
> Ludootje
> 
> On Wed, 2004-02-04 at 22:06, Roman Jordan wrote:
> > Hi,
> > i use a sony laptop with kernel 2.6.1 and acpi support. If i want do
> > switch it off the device, using the command 'halt' or 'poweroff' the
> > laptop does not switch off. I only get the message 'system haltet'. If
> > use the kernel without ACPI, the display is drawing black, but the
> > device is also not swiched off.
> > If i using the fedora standard kernel 2.4.22-1.2115.nptl the 'halt'
> > command works fine.
> > Any ideas?
> > 
> > Regards,
> > Roman Jordan
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

-- 
GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++

