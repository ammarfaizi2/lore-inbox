Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVCWIJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVCWIJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVCWIJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:09:16 -0500
Received: from [218.1.67.73] ([218.1.67.73]:4769 "EHLO trust-mart.com")
	by vger.kernel.org with ESMTP id S262863AbVCWIJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:09:12 -0500
Message-ID: <000a01c52f7f$94801060$d87f11ac@hv>
From: "hv" <hv@trust-mart.com>
To: "hv" <hv@trust-mart.com>
Cc: <linux-kernel@vger.kernel.org>
References: <034c01c52f7d$85843a20$d87f11ac@hv>
Subject: Re: memory size
Date: Wed, 23 Mar 2005 16:09:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1289
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1289
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other dell6650 with 16G ram under kernel 2.6.11-rc4-mm1 is more oddness.
Memory: 16116752k/16777216k available (1855k kernel code, 135136k reserved, 
702k data, 164k init, 15335296k highmem)


----- Original Message ----- 
From: "hv" <hv@trust-mart.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, March 23, 2005 3:54 PM
Subject: memory size


> Hi,all:
> This is my memory status from "dmesg":
> Memory: 4673020k/5242880k available (1334k kernel code, 44532k reserved, 
> 672k data, 156k init, 3800960k highmem)
>
>
> But I found that available memory size is much less than physical memory 
> size.My server is Dell6650 with P4 Xeon*4 and 5G Ram.
> My kernel version is 2.6.12-rc1-mm1.Could any one tell my the 
> reason?Thanks.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> 


