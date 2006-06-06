Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWFFOb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWFFOb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWFFOb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:31:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43398 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932191AbWFFOb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:31:59 -0400
Date: Tue, 6 Jun 2006 16:31:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mark Lord <lkml@rtr.ca>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux UWB and Wireless USB project
Message-ID: <20060606143108.GB6980@elf.ucw.cz>
References: <F989B1573A3A644BAB3920FBECA4D25A063F1984@orsmsx407> <20060605231233.GJ3469@elf.ucw.cz> <44858B0F.7020704@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44858B0F.7020704@rtr.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 06-06-06 10:02:55, Mark Lord wrote:
> Pavel Machek wrote:
> >
> >Common cellphones are 2W, iirc; (so it would be ~1mW) but I was more
> >interested in system power consumption. WIFI is too power intensive
> >for a cellphone (mostly). Is this designed to go into cellphones?
> >notebooks?
> 
> Most mobile phones in North America typically max out at 0.5W,
> and spent much of the time operating in the uW - mW txpower range.
> 
> I've forgotten the specs for GSM in Europe.

2W max on 900MHz, and 1W max on 1800MHZ, IIRC. Yes, they can go down
on good signal.

But power that goes out of the antena is not the only power
spent... GSM phones have about 5hours theoretical talk time on ~3.6Wh
battery. That means they eat around ~.5W in the best case.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
