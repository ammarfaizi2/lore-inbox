Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTJ2MuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 07:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTJ2MuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 07:50:14 -0500
Received: from mail01.mail.esat.net ([193.120.142.6]:33751 "EHLO
	mail01.mail.esat.net") by vger.kernel.org with ESMTP
	id S262056AbTJ2MuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 07:50:06 -0500
Message-ID: <07d701c39e1b$2c764580$6e69690a@RIMAS>
From: "Remus" <rmocius@auste.elnet.lt>
To: <linux-kernel@vger.kernel.org>
References: <E1AEpd5-0000Se-QI@rhn.tartu-labor>
Subject: Re: PCI Bus error 6290 or 0290
Date: Wed, 29 Oct 2003 12:49:34 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried all PCI slots, but still shows the same errors.

Remus

----- Original Message ----- 
From: "Meelis Roos" <mroos@linux.ee>
To: <rmocius@auste.elnet.lt>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 29, 2003 12:40 PM
Subject: Re: PCI Bus error 6290 or 0290


> R> I have installed the latest 2.6.0-test9 kernel and I get this error
> R> messages:
> R> Oct 29 13:51:39 fw kernel: eth1: PCI Bus error 6290.
> R> Oct 29 13:51:39 fw kernel: eth1: PCI Bus error 0290.
> R>
> R> The problem is with Realtek (RTL-8139) network card drivers.
> [...]
> R> Any ideas/solutions?
>
> I had the same problem on a K6-2 with some Asus MB. Both Realtek 8139
> and tulip (21140) refused to work in a PCI slot. Realtek gave these
> messages, tulip told that send timed out. A quick workaround was to put
> the NIC into another PCI slot. I don't know the real reason and I don't
> have the specific computer available for additional tests any more.
>
> -- 
> Meelis Roos (mroos@linux.ee)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

