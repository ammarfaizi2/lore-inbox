Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030905AbWKUL5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030905AbWKUL5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030902AbWKUL5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:57:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5761 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030905AbWKUL5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:57:06 -0500
Date: Tue, 21 Nov 2006 12:56:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Siemens SX1: sound cleanups
Message-ID: <20061121115619.GB2423@elf.ucw.cz>
References: <20061119114938.GA22514@elf.ucw.cz> <s5h4psus8n9.wl%tiwai@suse.de> <20061121114811.GA2423@elf.ucw.cz> <s5hodr1j9r5.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hodr1j9r5.wl%tiwai@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-11-21 12:54:06, Takashi Iwai wrote:
> At Tue, 21 Nov 2006 12:48:11 +0100,
> Pavel Machek wrote:
> > 
> > On Mon 2006-11-20 11:40:58, Takashi Iwai wrote:
> > > At Sun, 19 Nov 2006 12:49:38 +0100,
> > > Pavel Machek wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > These are cleanups for codingstyle in sound parts of siemens sx1. They
> > > > should not change any code. Please apply,
> > > 
> > > Which tree does include these drivers?
> > > I've never seen nor review it...
> > 
> > I'm just now sending cleanups to Vladimir; he's the person writing
> > those. His tree is only available as patches.
> > 
> > I thought I'd push them through omap tree, but if alsa wants to take
> > them instead, I have no problem with that.
> 
> I don't care which tree contains the driver, too.
> 
> I was just concerned by that the driver code hasn't been reviewed by
> sound subsystem developers at all.

It is not in _that_ stage, yet. We are currently cleaning it for
submission.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
