Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279846AbRKFRKM>; Tue, 6 Nov 2001 12:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279839AbRKFRKG>; Tue, 6 Nov 2001 12:10:06 -0500
Received: from babel.spoiled.org ([217.13.197.48]:59796 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S279832AbRKFRJh>;
	Tue, 6 Nov 2001 12:09:37 -0500
From: Juri Haberland <juri@koschikode.com>
To: dz@cs.unitn.it (Massimo Dal Zotto)
Cc: linux-kernel@vger.kernel.org, stephane@tuxfinder.org
Subject: Re: [PATCH] SMM BIOS on Dell i8100
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <200111061645.RAA02115@fandango.cs.unitn.it>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20011106170934.734231195E@a.mx.spoiled.org>
Date: Tue,  6 Nov 2001 18:09:34 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111061645.RAA02115@fandango.cs.unitn.it> you wrote:
>> 
>> Actually, I just tried plain 2.4.14-pre8 and the i8k-module *didn't*
>> work with my i8000, but with the patch from Stephane it *does* ;)
>> 
>> Happy happy, joy joy...
>> 
>> Juri
>> 
>> PS: BIOS verion A17 if that matters

> Hi,
> 
> I have released version 1.2 of the driver. It contains Stephane's patches
> for the I8100, a new i8kmon and some documentation. You can download from:
> 
>     http://www.debian.org/~dz/i8k/
> 
> Could you please explain what doesn't work with your I8000? Does the
> module load? Can you read /proc/i8k?

Yes, sure, sorry. The module (from 2.4.14pre8) loaded perfectly and I could
read /proc/i8k. Also controlling the fans worked. The only thing that didn't
work was the key-thingy. Pressing any of the five keys (those two near the
power button and the Fn-keys) didn't do anything with the i8kbuttons script.

Btw Thank You Very Much!

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

