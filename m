Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKCXi4>; Sat, 3 Nov 2001 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRKCXir>; Sat, 3 Nov 2001 18:38:47 -0500
Received: from [217.158.48.116] ([217.158.48.116]:24071 "HELO violet.gyron.net")
	by vger.kernel.org with SMTP id <S276344AbRKCXii>;
	Sat, 3 Nov 2001 18:38:38 -0500
Message-ID: <001901c164c0$a44fdbc0$3200a8c0@seduction>
From: "Chris King" <chris@admins.devour.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE45F72.2010900@candelatech.com>
Subject: Re: [OT] RH 2.4.7 kernel panic:  How to get a new kernel on there?
Date: Sat, 3 Nov 2001 23:38:28 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just upgraded my VAIO PCG-fx210 to RH 7.2 (from RH 7.1 + custom kernel).
> I also upgraded to GRUB.
>
> Now, the kernel panics every time when I try too boot.

This isn't exactly relevant to what you're asking.. but I have similar
troubles with my Vaio PCG-FX101 and 2.4.x.
I found that I couldn't make it boot without spending a long time playing
with the PCMCIA options, and it still locks up whenever I insert a cardbus
card.
This could be related to your problems - regardless of whether or not you
have PC Card inserted, there are certain cardbus chips which seem to lock up
in 2.4.x.



> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>


