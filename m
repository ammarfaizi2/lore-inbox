Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281323AbRKVSvp>; Thu, 22 Nov 2001 13:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281449AbRKVSve>; Thu, 22 Nov 2001 13:51:34 -0500
Received: from mail-r5.shlink.de ([212.60.1.141]:39173 "HELO mail-r5.shlink.de")
	by vger.kernel.org with SMTP id <S281326AbRKVSvU>;
	Thu, 22 Nov 2001 13:51:20 -0500
Date: Thu, 22 Nov 2001 18:21:44 +0100 (CET)
From: Peter Adebahr <adsys@adebahr.de>
Reply-To: <peter@adebahr.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
In-Reply-To: <001201c1735c$9ac546d0$0b01a8c0@lotus>
Message-ID: <Pine.LNX.4.33.0111221812580.30318-100000@siraly.adebahr.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SHLINK: Mail autoscanned by SHLINK-VirusScan
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Ishak Hartono wrote:

> I tried to compile 2.4.14 and successfully detect the digital 21143 network
> card, however, i can't ping out
> 
> 

I have had the same problem with my older 21140 card, which I have
replaced a couple of days ago. In other systems, I have 21143 cards,
which all behave as expected (all -ac kernels until last one).

There was an easy remedy, however: use the tulip-0.9.14 or 1.1.8 drivers.

Good Luck,
Peter


