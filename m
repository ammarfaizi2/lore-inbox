Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSBPVrh>; Sat, 16 Feb 2002 16:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292556AbSBPVr2>; Sat, 16 Feb 2002 16:47:28 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:23055 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S292553AbSBPVrI>;
	Sat, 16 Feb 2002 16:47:08 -0500
Date: Thu, 14 Feb 2002 22:47:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Panin <pazke@orbita1.ru>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sys & legacy buses plus interrupt controller and IDE support
Message-ID: <20020214214750.GA486@elf.ucw.cz>
In-Reply-To: <20020212085954.GA618@elf.ucw.cz> <20020214080645.GA281@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020214080645.GA281@pazke.ipt>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, Feb 12, 2002 at 09:59:55AM +0100, Pavel Machek wrote:
> > Here it goes. For now I only put one device on each bus (sys &
> > legacy), but I'll quickly expand it once merged. Please apply,
> 
> please take a quick look at attached patch. It's your patch with
> minor modification, hwif->pci_dev used as parent for ide interface.
> 
> I made it because it was strange to see HPT370 IDE interface
> under legacy bus :))

Thanx, applied. [Dunno when/if I'm able to push this to linus. I'll
certainly try.]
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
