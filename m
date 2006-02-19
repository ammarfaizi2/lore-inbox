Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWBSVoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWBSVoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBSVoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:44:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55761 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932273AbWBSVoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:44:24 -0500
Date: Sun, 19 Feb 2006 22:44:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ghrt <ghrt@dial.kappa.ro>, kernel list <linux-kernel@vger.kernel.org>,
       perex@suse.cz, tiwai@suse.de
Subject: Re: No sound from SB live!
Message-ID: <20060219214408.GL15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <200602190127.27862.ghrt@dial.kappa.ro> <20060218234805.GA3235@elf.ucw.cz> <1140310710.2733.315.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140310710.2733.315.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I tried enabled everything I could in alsamixer, but still could not
> > get it to produce some sound :-(. 
> 
> Is 2.6.15.4 also broken?

2.6.15.4 does not have support for my SATA controller, so it would be
quite complex to test that... I may have something wrong with
userspace, but alsamixer all to max, then cat /bin/bash > /dev/dsp
should produce some sound, no?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
