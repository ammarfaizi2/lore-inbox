Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278789AbRKDF0T>; Sun, 4 Nov 2001 00:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278797AbRKDF0K>; Sun, 4 Nov 2001 00:26:10 -0500
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:49413 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S278789AbRKDFZ6>; Sun, 4 Nov 2001 00:25:58 -0500
Subject: Re: Via Onboard Audio - Round #2
From: Sean Middleditch <elanthis@awesomeplay.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE4CC20.5FFEC4B5@mandrakesoft.com>
In-Reply-To: <1004849558.457.15.camel@stargrazer> 
	<3BE4CC20.5FFEC4B5@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 04 Nov 2001 00:30:18 -0500
Message-Id: <1004851818.457.24.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 at 00:03, Jeff Garzik wrote:
> 
> You cannot, through driver options.
> 
> The IRQ routing conflict is definitely the problem.  You can try booting
> with "PNP OS: No" and maybe other irq options are hidden in your BIOS
> setup under an advanced menu.
> 

There is no option.  Trust me, I know BIOS setups, and unless they
really hid the option well (I.E., not having it in the menus at all)
it's not there.  The audio worked fine in WindowXP, obviously an OS and
drivers can handle it.  This is a limitation and/or problem with Linux
and it's Via Audio driver.  How can I get around this, or do I need to
reinstall WindowsXP to use the audio?

(Sorry if I sounded harsh, but I just got done bitching at a couple
companies pissing me off lately... I'm not in a put-up-with-crap mood
right now  ^,^  After I sleep a little I will behave better, I promise.)

Thanks guys,
Sean Etc.

> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 


