Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWBSVrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWBSVrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWBSVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:47:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57041 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932280AbWBSVrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:47:17 -0500
Date: Sun, 19 Feb 2006 22:47:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060219214702.GM15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com> <7c3341450602190318o1c60e9b5w@mail.gmail.com> <20060219205157.GA5976@us.ibm.com> <1140384638.2733.389.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140384638.2733.389.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 16:30:37, Lee Revell wrote:
> On Sun, 2006-02-19 at 12:51 -0800, Nishanth Aravamudan wrote:
> > I run Ubuntu Breezy, which has:
> > 
> > alsa-utils = 1.0.9a-4ubuntu5 
> 
> The alsa-utils version should not matter, it's alsa-lib that must be
> kept in sync with the ALSA version in the kernel.

Ugh, not a good news. How do I tell if my alsa libs are recent enough?
It should at least warn, no?

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
