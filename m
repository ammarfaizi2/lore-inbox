Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbTEFT14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTEFT14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:27:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8461 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261199AbTEFT1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:27:55 -0400
Date: Tue, 6 May 2003 21:40:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: serial ioctl emulation done right
Message-ID: <20030506194027.GA5727@atrey.karlin.mff.cuni.cz>
References: <20030506184731.GA5419@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506184731.GA5419@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What about this one? This makes it possible to kill copy from
> x86-64/ia32/ia32_ioctl.c, and adds support for setserial on all
> architectures...

It actually introduces very ugly warnings, I'm working ont that.
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
