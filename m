Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTJSQpr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJSQpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:45:47 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:13696 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262038AbTJSQpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:45:46 -0400
Message-ID: <006501c39660$cf306cf0$0514a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: <linux-kernel@vger.kernel.org>
References: <00b801c3955c$7e623100$0514a8c0@HUSH> <48236.192.168.9.10.1066565636.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 18:48:22 +0200
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

> I have tested the kernel hpt374 drivers with all possible kernel
> configurations with and without ACPI/APM, local apic, io-apic and
> they don't seem to change anything in my case. I just get the following
> error message sooner or later and the whole system hangs.
> 
> Sep 26 23:07:42 alderan kernel: blk: queue c0466908, I/O limit 4095Mb
> (mask 0xffffffff)
> Sep 26 23:07:42 alderan kernel: hde: dma_timer_expiry: dma status == 0x20
> Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA
> Sep 26 23:07:42 alderan kernel: hde: timeout waiting for DMA

This is the EXACT same things I see in my logs.
> 
> It might be that my problems are somehow related to the motherboards
> I've been using, as the first one is "Epox 8K9A3+ (Via KT400 chipset)"
> while the another one is "Epox 4PCA3+ (Intel 875p chipset)". But they
> are 100% reproduceble with multiple brands of disk-drives.

Mine is an Asus CUSL2, Pentium III motherboard with 512 Mb.


