Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbRFNPYe>; Thu, 14 Jun 2001 11:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263118AbRFNPYX>; Thu, 14 Jun 2001 11:24:23 -0400
Received: from babel.spoiled.org ([212.84.234.227]:55416 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S263084AbRFNPYR>;
	Thu, 14 Jun 2001 11:24:17 -0400
Date: 14 Jun 2001 15:24:15 -0000
Message-ID: <20010614152415.9773.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: david.lombard@mscsoftware.com (\"David N. Lombard\")
Cc: linux-kernel@vger.kernel.org;, haberland@altus.de
Subject: Re: 2.4.5-ac13, APM, and Dell Inspiron 8000
In-Reply-To: <3B28CFBF.4B7639D2@mscsoftware.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
> Juri Haberland wrote:
>> 
>> Ok, I just tried that and my i8000 locked up as well. No problems with
>> 2.4.5 as well. I have also another problem:
>> Running with -ac13 it doesn't poweroff properly - but it did running
>> 2.4.5. Sometimes it just stops where it should poweroff and locks hard,
>> sometimes it blanks the display before locking up hard.
> 
> The Dell i5000e crashes when switching between mains and battery when
> the disk is active, so you might try to plug/unplug with the system
> quiet.
> 
> If this works, you'll be in a *little* better spot.
> 
> As for hanging, you might try suspending it (i.e., close the display)
> and opening it back up.  This works for the i5000e; it also clears the
> display that sometimes goes *nuts* when switching video modes.  This
> last behavior has only surfaced with the latest A06 BIOS.

Hi,
I didn't have all these problems when running 2.4.5 or 2.4.6-pre2.
So there is something odd in Alan's tree (I assume).

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

