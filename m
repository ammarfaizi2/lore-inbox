Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbRFNJH4>; Thu, 14 Jun 2001 05:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbRFNJHr>; Thu, 14 Jun 2001 05:07:47 -0400
Received: from babel.spoiled.org ([212.84.234.227]:57365 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S261791AbRFNJHk>;
	Thu, 14 Jun 2001 05:07:40 -0400
Date: 14 Jun 2001 09:07:38 -0000
Message-ID: <20010614090738.30539.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: georgn@somanetworks.com
Cc: linux-kernel@vger.kernel.org;, haberland@altus.de
Subject: Re: 2.4.5-ac13, APM, and Dell Inspiron 8000
In-Reply-To: <15143.40342.373565.892231@somanetworks.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
> 
> I've been running 2.4.5 on my new Dell I8000 without too many
> problems.  Last night I built -ac13 (on my porch) and booted it
> without incident.  Later, going inside and re-connecting the AC I
> notice that the thing's hung.  I play around a bit and discover that
> the act of plugging or unplugging the power cord will hang the box.
> 
> This lead me to disable all power manglement in the BIOS.  No joy.
> 
> This problem does not exist using straight 2.4.5.
> 
> Has anybody else seen this?  Any debugging suggestions?  Or stated
> differently, has anybody with this machine arrived at a configuration
> that avoids weirdness in the power management framework?

Ok, I just tried that and my i8000 locked up as well. No problems with
2.4.5 as well. I have also another problem:
Running with -ac13 it doesn't poweroff properly - but it did running
2.4.5. Sometimes it just stops where it should poweroff and locks hard,
sometimes it blanks the display before locking up hard.

Alan, what other infos do you need?

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

