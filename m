Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUDAL3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUDAL3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:29:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:47754 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262852AbUDAL3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:29:00 -0500
Date: Thu, 01 Apr 2004 16:54:02 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: Re: UART detection?
To: Rui Santos <rsantos@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <009401c417db$da971e70$7f476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <20040401112624.6957A337F4@rd-server.pie.domain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to detect this inside a kernel module. Any way to do it?

Regards
Mohanlal

----- Original Message -----
From: "Rui Santos" <rsantos@grupopie.com>
To: "'mohanlal jangir'" <mohanlal@samsung.com>
Sent: Thursday, April 01, 2004 4:56 PM
Subject: RE: UART detection?


> Hi,
>
> You can find them on the kernel boot messages.
> Something like: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>
> This log is usualy found at /var/log/messages
>
> Regards
> Rui Santos
>
>
> -----Mensagem original-----
> De: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] Em nome de mohanlal jangir
> Enviada: quinta-feira, 1 de Abril de 2004 12:02
> Para: linux-kernel@vger.kernel.org
> Assunto: UART detection?
>
> How can I find in a kernel module, how many UARTs are present in my
system?
> And how can I find their IO address and IRQ?
>
> Regards
> Mohanlal
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

