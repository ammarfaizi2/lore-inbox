Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUFHJeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUFHJeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUFHJeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:34:10 -0400
Received: from gprs214-162.eurotel.cz ([160.218.214.162]:21632 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262322AbUFHJeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:34:00 -0400
Date: Tue, 8 Jun 2004 11:17:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040608091709.GC2569@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <20040607140511.GA1467@elf.ucw.cz> <40C47B94.6040408@scienion.de> <20040607144841.GD1467@elf.ucw.cz> <40C53D80.2080603@tequila.co.jp> <20040608085814.GA1269@elf.ucw.cz> <40C580BE.1030802@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C580BE.1030802@tequila.co.jp>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> |>| PCMCIA... well, that's another obsolete technology. Too bad.
> |>
> |>PCMCIA is obsolete? Did I miss something, or was this a joke?
> |
> |
> | Obsoleted by cardbus, I believe. (cardbus cards look like PCMCIA
> | cards, but electrical protocol is different) Plus, as someone else
> | noted, stuff moves into mainboard. USB also replacs part of what
> | PCMCIA was for.
> 
> hmm, I didn't know that there is a change from PCMCIA to cardbus.
> Thought still there are lot of pcmcia stuff around. wlan cards, eg my
> dial up card (CF card into a PCMCIA adapter). Well I wouldn't abandon
> PCMCIA so fast. At least the linux kernel is know for beeing able to use
> very old hardware in a very good way ...

Yes, pcmcia still survives in form of compactflash, mostly used by
low-powered handhelds etc. That's where ISA survives too.

I agree that supporting PCMCIA is usefull, and that linux should run
on old hardware; but you can see that PCMCIA and APM is in "old
hardware" category, along with ISA, Pentium I CPUs and serial ports.

Linux still tries to support 386 cpus, and its right. However its not
same level of support as modern hardware.
								Pavel 
-- 
934a471f20d6580d5aad759bf0d97ddc
