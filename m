Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbSLROnP>; Wed, 18 Dec 2002 09:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbSLROnP>; Wed, 18 Dec 2002 09:43:15 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:55462 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S267256AbSLROnO>; Wed, 18 Dec 2002 09:43:14 -0500
Message-ID: <001501c2a6a4$e76fb3e0$7900a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>, "Horst von Brand" <vonbrand@inf.utfsm.cl>
References: <200212181410.gBIEAod6027746@pincoya.inf.utfsm.cl>
Subject: Re: Intel P6 vs P7 system call performance 
Date: Wed, 18 Dec 2002 15:51:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Horst von Brand" <vonbrand@inf.utfsm.cl>
> > How are system calls a new feature?  Or is optimizing an existing
> > feature not allowed by your definition of "feature freeze"?
>
> This "optimizing" is very much userspace-visible, and a radical change in
> an interface this fundamental counts as a new feature in my book.

Since int 0x80 is supported/ will be supported for the next 20 years, I dont
think this is a radical change.
No userspace visible at all.
You are free to use the old way of calling the kernel...

