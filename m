Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVH0Kts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVH0Kts (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVH0Ktr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 06:49:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1490 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030361AbVH0Ktr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 06:49:47 -0400
Date: Sat, 27 Aug 2005 12:49:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@dominikbrodowski.net>, axboe@suse.de,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc7: crash on removing CF card
Message-ID: <20050827104935.GA3177@elf.ucw.cz>
References: <20050825094846.GA2097@elf.ucw.cz> <20050825120320.GA22920@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825120320.GA22920@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Thu, Aug 25, 2005 at 11:48:46AM +0200, Pavel Machek wrote:
> > Something went wrong with PCMCIA on this X32. I inserted CF card, but
> > it detected both hde *and* hdf, mount took forever. At that point I
> > decided that I want my CF card back, took it back, it started
> > producing different I/O errors , and then it oopsed.
> 
> Did this happen also with 2.6.13-rc[3-6]?

I can easily try -rc6-mm2; I have not had earlier kernels here, but
can go back to them if neccessary.

-- 
if you have sharp zaurus hardware you don't need... you know my address
