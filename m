Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSA0XKB>; Sun, 27 Jan 2002 18:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSA0XJw>; Sun, 27 Jan 2002 18:09:52 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:10246 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289055AbSA0XJm>;
	Sun, 27 Jan 2002 18:09:42 -0500
Date: Sun, 27 Jan 2002 21:52:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: preempt & ne2k
Message-ID: <20020127215253.A793@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > testing the patch complaining about, AND one that seems like it could be 
> > addressed by using IRQ disabling as a latency guard in addition to spinlocks.
> 
> I dont believe anyone has tested the driver hard with pre-empt. Its not that
> this driver can't be fixed. Its that this is one tiny example of maybe 
> thousands of other similar flaws lurking. There is no obvious automated way
> to find them either.

So.... you have shown performance problem in one driver. Maybe *bad*
performance problem, but only performance problem. There may be other
performance problems out there. And what?
								Pavel
-- 
When do you have heart between your knees?
