Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVC2Uks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVC2Uks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVC2Uks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:40:48 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:3559 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261418AbVC2UkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:40:09 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Lee Revell <rlrevell@joe-job.com>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050329185825.GB20973@irc.pl>
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792462.23430.25.camel@mindpipe>  <20050329185825.GB20973@irc.pl>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 15:40:07 -0500
Message-Id: <1112128807.5141.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 20:58 +0200, Tomasz Torcz wrote:
> On Fri, Mar 25, 2005 at 06:14:22PM -0500, Lee Revell wrote:
> > On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > > - audio works too. The only problem is that two applications can't
> > > open /dev/dsp in the same time.
> > 
> > Not a problem.  ALSA does software mixing for chipsets that can't do it
> > in hardware.  Google for dmix.
> > 
> > However this doesn't (and can't be made to) work with the in-kernel OSS
> > emulation (it works fine with the alsa-lib/libaoss emulation).  So you
> 
>  quake3 still segfaults when run through "aoss". And can't be fixed, as
> it's closed source still.
> 

I guess that's Quake3's problem...

Lee

