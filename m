Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTA1Kmg>; Tue, 28 Jan 2003 05:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTA1Kmg>; Tue, 28 Jan 2003 05:42:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3588 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265135AbTA1Kmf>;
	Tue, 28 Jan 2003 05:42:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281052.h0SAqW1n000148@darkstar.example.net>
Subject: Re: AW: AW: Bootscreen
To: Raphael_Schmid@CUBUS.COM (Raphael Schmid)
Date: Tue, 28 Jan 2003 10:52:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <398E93A81CC5D311901600A0C9F29289469375@cubuss2> from "Raphael Schmid" at Jan 28, 2003 11:33:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There is a boot option to do this, but I can't remember what it is :-)
> What you mean, I believe, is "quiet".

Yep, that's it :-)

> > LILO loading linux...
> > Uncompressing the kernel...
> Yeah, these can be easily supressed, somewhere in arch/i386/boot/compressed
> 
> Are you in effect saying that Linux is *not* reinitializing the display,
> but the bootloader is?

No.

If you use the framebuffer, the kernel re-initialises the display when
it boots.

John.
