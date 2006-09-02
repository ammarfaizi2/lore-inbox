Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWIBTzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWIBTzc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWIBTzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:55:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4751 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751462AbWIBTzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:55:31 -0400
Date: Sat, 2 Sep 2006 21:55:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bas Bloemsaat <bas.bloemsaat@gmail.com>
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Vicam driver, device
Message-ID: <20060902195518.GA13197@elf.ucw.cz>
References: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have an old webcam, a Compro PS39U. By windows it's recognized as
> vicam and works with the vicam driver. With Linux it didn't work.
> lsusb showed that it identifies different than camera's recognized by
> the vicam driver. So I added the usb id to vicam.c, and it now
> produces images through the driver under Linux too. It's still a
> shitty camera though.
> 
> I'm submitting the change, maybe someone else has this camera and
> want's to use it.
> 
> --- drivers/media/video/usbvideo/vicam.c	2006-08-23 
> 23:16:33.000000000 +0200
> +++ drivers/media/video/usbvideo/vicam.c.compro	2006-09-02
> 19:45:20.000000000 +0200

You want to fix your mailer, it word wraps.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
VGER BF report: U 0.5
