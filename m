Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbSJ2Pgr>; Tue, 29 Oct 2002 10:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSJ2Pgr>; Tue, 29 Oct 2002 10:36:47 -0500
Received: from mx2.fcservices.com ([64.245.25.141]:56594 "HELO
	mx2.fcservices.com") by vger.kernel.org with SMTP
	id <S261946AbSJ2Pgm>; Tue, 29 Oct 2002 10:36:42 -0500
Subject: Re: [2.5.44] Poweroff after warm reboot
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200210291031.11837.devilkin-lkml@blindguardian.org>
References: <200210291031.11837.devilkin-lkml@blindguardian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Oct 2002 10:42:02 -0500
Message-Id: <1035906122.19299.8.camel@sparky>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 04:31, DevilKin wrote:
> Hello,
> 
> If I reboot my laptop with kernel 2.5.44 (warm reboot), the machine reboots, 
> loads the kernel, and then in the middle of the booting process powers off. 
> 
> Doing an actual shutdown (poweroff) results in a clean boot next time.
> 
> Is this a known bug?
> 
> PC is a Dell Latitude CPI A XT 366. More info available if needed.

FWIW I have a very similar machine (its not in front of me
unfortunately) that used to exhibit the same behavior under Win2k.  I
haven't been using it since I got into a position to put it back under
Linux (the battery is shot - I was just using it to run software
required by my old ISP) but I can give it a try if needed.

It was exactly as described, only under windows - the machine would
reboot, bios go past, the initial boot menu would go, then partway
though the color-bar boot screen it would just turn off.


