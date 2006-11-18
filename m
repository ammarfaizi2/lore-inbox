Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756068AbWKRAig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbWKRAig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756111AbWKRAig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:38:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52363 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756068AbWKRAif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:38:35 -0500
Date: Sat, 18 Nov 2006 01:38:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Basic support for siemens sx1
Message-ID: <20061118003816.GA9187@elf.ucw.cz>
References: <20061116170209.GA5544@elf.ucw.cz> <20061117175431.GD6072@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117175431.GD6072@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> * Pavel Machek <pavel@ucw.cz> [061116 19:04]:
> > From: Vladimir Ananiev <vovan888@gmail.com>
> > 
> > This adds basic support for Siemens SX1. More patches are available,
> > with video driver, mixer, and serial ports working. That is enough to
> > do gsm calls with right userland.
> 
> Cool.

:-)

> > It would be nice to get basic patches merged to the -omap tree... do
> > they look ok?
> 
> Yeah, looks good, except for the i2c part. Is Sofia really a TI PCF8574
> i2c chip? In that case it could use the gpioexpander code.  
> 
> Anyways, let's plan on pushing this to linux-omap tree, then do the
> changes for gpioexpander, and send that upstream too.

Works for me. I'll check with google to find out what sofia really is.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
