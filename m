Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTKXLBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 06:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTKXLBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 06:01:09 -0500
Received: from mail.icablenet.com.br ([200.215.9.228]:46609 "EHLO
	mail.icablenet.com.br") by vger.kernel.org with ESMTP
	id S263732AbTKXLBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 06:01:07 -0500
Message-ID: <00bc01c3b2ac$92423f40$0201a8c0@bigip>
Reply-To: "Rivalino Matias Jr." <rmj@icablenet.com.br>
From: "Rivalino Matias Jr." <rmj@icablenet.com.br>
To: <linux-kernel@vger.kernel.org>
References: <5391330$10685535353fb0d53fa2c2f6.53836761@config16.schlund.de>
Subject: Re: HPT37x and Software RAID
Date: Mon, 24 Nov 2003 09:01:14 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try use the kernel parameter (linux hdx=noprobe, ....) for the hard disks
attached to the HPT controller. You can get the HPT3xx module´s source code
from the www.highpoint-tech.com website.

Rivalino.
----- Original Message ----- 
From: <info@realdos.de>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 11, 2003 4:30 AM
Subject: HPT37x and Software RAID


>
> Hello,
>
> I tried to Run a 2.6 Kernel, but in the configuration is no "Software
> RAID" entry like in 2.4.22. I tried to run the kernel, but the kernel
> panic says "Unable to mount root"...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

