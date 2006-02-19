Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWBSVul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWBSVul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWBSVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:50:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55484 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751029AbWBSVuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:50:40 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060219214702.GM15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
	 <7c3341450602190318o1c60e9b5w@mail.gmail.com>
	 <20060219205157.GA5976@us.ibm.com> <1140384638.2733.389.camel@mindpipe>
	 <20060219214702.GM15311@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 16:50:36 -0500
Message-Id: <1140385837.2733.394.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 22:47 +0100, Pavel Machek wrote:
> On Ne 19-02-06 16:30:37, Lee Revell wrote:
> > On Sun, 2006-02-19 at 12:51 -0800, Nishanth Aravamudan wrote:
> > > I run Ubuntu Breezy, which has:
> > > 
> > > alsa-utils = 1.0.9a-4ubuntu5 
> > 
> > The alsa-utils version should not matter, it's alsa-lib that must be
> > kept in sync with the ALSA version in the kernel.
> 
> Ugh, not a good news.

This has been the case for ages (distros still get it wrong).  It is not
an ideal situation.

>  How do I tell if my alsa libs are recent enough?

1.0.10 should be OK

> It should at least warn, no?

Yes.

Lee

