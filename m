Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135774AbRDTBcc>; Thu, 19 Apr 2001 21:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135775AbRDTBcV>; Thu, 19 Apr 2001 21:32:21 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:17553 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S135774AbRDTBcM>; Thu, 19 Apr 2001 21:32:12 -0400
Date: Fri, 20 Apr 2001 02:29:09 +0100 (IST)
From: Paul Jakma <paul@jakma.org>
To: Andreas Dilger <adilger@turbolinux.com>
cc: <linux-lvm@sistina.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jes Sorensen <jes@linuxcare.com>, <linux-kernel@vger.kernel.org>,
        <linux-openlvm@nl.linux.org>, Arjan van de Ven <arjanv@redhat.com>,
        Jens Axboe <axboe@suse.de>, Martin Kasper Petersen <mkp@linuxcare.com>,
        <riel@conectiva.com.br>
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <200104191945.f3JJjKRn015661@webber.adilger.int>
Message-ID: <Pine.LNX.4.33.0104200218460.1083-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Andreas Dilger wrote:

> went in, but not other stuff.  Also, it doesn't appear that any of the
> LVM changes are making it into the stock kernel, which is basically a
> recepie for disaster.

agreed... after the problematic inclusion of 0.9 into the kernel i
asked on sistina LVM list whether they could try to be a bit more
proactive about feeding patches on to linus, to make life easier for
LVM users - they had fixes for the problems of 0.9 but never, and
still to this day have not, fed the code on.

Still to this day, nothing from them but announcements on l-k of
various betas. AFAIK all the patches for LVM submitted to linus since
0.8 went in have been from core linux developers (Andrea, Jens,
etc.), not sistina.

shame... their LVM is really nice to use. Just frustrating that they
do want to feed the code on... more frustrating still when you
consider the lobbying that went on to try persuade l-k that LVM
should go in.

> Cheers, Andreas

obHiddenCode: lm-sensors... used to use this a long time ago.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Happiness is twin floppies.

