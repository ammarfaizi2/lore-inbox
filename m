Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317954AbSFNQuN>; Fri, 14 Jun 2002 12:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317955AbSFNQuM>; Fri, 14 Jun 2002 12:50:12 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:3712 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S317954AbSFNQuL>; Fri, 14 Jun 2002 12:50:11 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'Raphael Manfredi'" <Raphael_Manfredi@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: The buggy APIC of the Abit BP6
Date: Fri, 14 Jun 2002 18:49:41 +0200
Message-ID: <004901c213c3$7a73b8f0$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Manfredi wrote:

> Here's my own solution for it, in an old article.  I've been running
> with this patch since then, and transmit timeouts have never been a
problem.
> 
> I run 2.4.18-pre7 nowadays, and the patch below applied without
problem.

Thanks very much! This looks very promising. I just patched
2.4.19pre10-ac2 with it and booted it up on my BP6. I will report back
any failure or success of APIC kicking ;)

BTW, did you get any explanation why this wasn't applied in -ac or main
kernel?

- Robbert Kouprie

