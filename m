Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTA1OZg>; Tue, 28 Jan 2003 09:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTA1OZg>; Tue, 28 Jan 2003 09:25:36 -0500
Received: from [64.8.50.193] ([64.8.50.193]:49397 "EHLO mta7.adelphia.net")
	by vger.kernel.org with ESMTP id <S266210AbTA1OZd>;
	Tue, 28 Jan 2003 09:25:33 -0500
Message-ID: <008101c2c6da$68e42eb0$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Raphael Schmid" <Raphael_Schmid@CUBUS.COM>,
       "'Robert Morris'" <rob@r-morris.co.uk>,
       "John Bradford" <john@grabjohn.com>
Cc: "Raphael Schmid" <Raphael_Schmid@CUBUS.COM>,
       <linux-kernel@vger.kernel.org>
References: <398E93A81CC5D311901600A0C9F29289469380@cubuss2>
Subject: Re: Bootscreen
Date: Tue, 28 Jan 2003 09:34:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do have a solution for that. Just make the image 640x440 instead
640x480,
> and have the initscripts output on one of the lower lines only, always
over-
> writing the previous message. That way, the support engineer would know
> what's going wrong and you'd still have a cute picture.

There's a good way to encode startup sequence info into the screen...it
doesn't require text.

WinXP outputs an image, starts it dim, fades it up to bright, starts a
sliding indicator, moves the slider back and forth at various speeds, then
starts the gui (?) and it goes more various steps.

I imagine someone with the right documentation could say exactly what's
going on at each step.



