Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUD1Gay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUD1Gay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbUD1Gay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:30:54 -0400
Received: from FE-mail03.albacom.net ([213.217.149.83]:38617 "EHLO
	FE-mail03.sfg.albacom.net") by vger.kernel.org with ESMTP
	id S264652AbUD1GaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:30:25 -0400
Message-ID: <000e01c42cea$5ea02720$0200a8c0@arrakis>
Reply-To: "Marco Cavallini" <linux@koansoftware.com>
From: "Marco Cavallini" <linux@koansoftware.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Greg KH" <greg@kroah.com>, <linux-kernel@vger.kernel.org>
References: <005c01c42b82$60d82f60$0200a8c0@arrakis> <20040426185612.GB28530@kroah.com> <003501c42c24$06e87940$0200a8c0@arrakis> <20040427171737.GB2465@mars.ravnborg.org> <000701c42c7e$20214810$0200a8c0@arrakis> <20040427175754.GA2968@mars.ravnborg.org>
Subject: Re: Problem with CONFIG_USB_SL811HS
Date: Wed, 28 Apr 2004 08:30:40 +0200
Organization: Koan s.a.s.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In Linux-2.4.26 the problem is in
> > drivers/usb/host/Makefile
>
> I assumed you were using the 2.6 kernel, so I did not
> even look at 2.4.
>
> Sorry for the noise.

No problem .
However I've noticed that the latest sources version for SL811 are in 2.4.26
and in 2.6.6 there are only the old one.
Could some linux-usb mantainer tell me if should be a good idea to update
these bringing sources from 2.4.26 and porting them to 2.6.6-rc2 ?
Thank you

Marco Cavallini

