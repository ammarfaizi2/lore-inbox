Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRLVWKe>; Sat, 22 Dec 2001 17:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRLVWKY>; Sat, 22 Dec 2001 17:10:24 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:23820 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S282707AbRLVWKR>; Sat, 22 Dec 2001 17:10:17 -0500
Message-ID: <002201c18b35$4def71f0$0801a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "John Weber" <weber@nyc.rr.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C24D5F1.3FF73EE0@nyc.rr.com>
Subject: Re: 2.4.17 OOPS: on Boot loading floppy driver
Date: Sat, 22 Dec 2001 22:09:18 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unable to handle kernel paging request at virtual address 0000413d
>  print eip:
> c0106ea6
> *pde = 00000000
> Oops: 0000
> CPU: 0
> EIP: 0010:[<c0106ea6>]    Not tained

what does the EIP value match in System.map ?
or from the kernel file ?

> EFLAGS: 00010286
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


