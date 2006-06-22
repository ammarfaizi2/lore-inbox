Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWFVX02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWFVX02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWFVX02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:26:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20375 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932191AbWFVX01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:26:27 -0400
Date: Fri, 23 Jun 2006 01:25:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ideas for more LED classes/triggers
Message-ID: <20060622232530.GA4790@elf.ucw.cz>
References: <20060622022006.GA17754@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622022006.GA17754@phoenix>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I saw the new LED subsystem in 2.6.17.1 (maybe earlier, but maybe it's
> been expanded?) and I thought of some ideas for more classes and
> triggers.
> 
> Classes:
> 	Keyboard LED's

...are handled by input subsystem. Leave them alone for now.

> 	Various laptop LED's (Asus, others)

Yes, this would be very welcome.

> Triggers:
> 	CPU busy (could include varieties such as user, system, IO
> > wait, etc.

That one would be nice.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
