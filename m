Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTA2NBQ>; Wed, 29 Jan 2003 08:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTA2NBQ>; Wed, 29 Jan 2003 08:01:16 -0500
Received: from 213-187-164-4.dd.nextgentel.com ([213.187.164.4]:64404 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265890AbTA2NBP> convert rfc822-to-8bit;
	Wed, 29 Jan 2003 08:01:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: John Bradford <john@grabjohn.com>, wa1hco@adelphia.net (jeff millar)
Subject: Scaring the non-geeks (was Bootscreen)
Date: Wed, 29 Jan 2003 14:09:57 +0100
User-Agent: KMail/1.4.1
Cc: Raphael_Schmid@CUBUS.COM, rob@r-morris.co.uk, linux-kernel@vger.kernel.org
References: <200301281440.h0SEeBS8001126@darkstar.example.net>
In-Reply-To: <200301281440.h0SEeBS8001126@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301291409.57213.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, I think the traditional text diagnostic messages are best kept
> as they are, otherwise we'll end up with bug reports like this:
>
> Date: Jan 28 14:39:29 2006
> Subject: Kernel 3.6.2 boot failiure
> To: linux-kernel@vger.kernel.org
>
> Hi,
>
> I just upgraded from 3.6.1, which booted fine, to 3.6.2, which stops
> after Tux has waved twice, and winked his left eye.

The point is that Linux should allow for a user-friendly image (yes! possibly 
with Tux winking with the eyes or something - in a Mac sorta way). This will 
allow for higher user-friendlyness, but should be turned off by default. That 
way, SuSE, RedHat and the rest can turn it on if they want to do support 
without the verbose messaging. Perhaps do it like 'if splash screen's active, 
one can disable it by holding SHIFT or something pressed down'.

I don't know about you, but most non-technical people DO NOT LIKE verbose 
messages they can't understand. My father was scared by the linux bootup when 
I installed Linux on their PC. I beleive most non-techies like the 'windows 
is now hopefully starting' screen. It shields the info they don't want.

So please - don't scare the 'normal' people with (in their eyes) verbose crap.

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

