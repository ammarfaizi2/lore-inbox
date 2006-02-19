Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWBSXrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWBSXrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBSXrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:47:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5561 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932457AbWBSXrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:47:11 -0500
Date: Mon, 20 Feb 2006 00:46:44 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060219234644.GD15608@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe> <200602192323.08169.s0348365@sms.ed.ac.uk> <1140391929.2733.430.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140391929.2733.430.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2 (one
> > that uses 
> > emu10k1). 
> 
> It's a specific change to the SBLive! that did not affect the Audigy
> that causes alsa-lib 1.0.10+ to be required on 2.6.14 and up.  These
> types of incompatible changes should be rare.

Do you have that patch somewhere handy?

How do I tell alsa-lib version?

Does alsa-lib bug still affect me when I'm using oss emulation?

> It was a necessary precursor to fixing the well known "master volume
> only controls front speakers" bug.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
