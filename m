Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUFTIPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUFTIPY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 04:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265308AbUFTIPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 04:15:24 -0400
Received: from gate.perex.cz ([82.113.61.162]:40585 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S264358AbUFTIPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 04:15:23 -0400
Date: Sun, 20 Jun 2004 10:13:01 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Ryan Anderson <ryan@michonline.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <20040620052836.GC28363@michonline.com>
Message-ID: <Pine.LNX.4.58.0406201010360.3528@pnote.perex-int.cz>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
 <40D23EBD.50600@opensound.com> <20040618102523.GA7103@merlin.emma.line.org>
 <20040620052836.GC28363@michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Ryan Anderson wrote:

> > What do I need commercial OSS for after all when Alsa works well for me?
> 
> Well, for what it's worth, there are a few devices out there for which
> there is no open source driver:
> 0000:02:02.0 Multimedia audio controller: Creative Labs [SB Live! Value]
> EMU10k1X
> (Dell Dimension 2100, *I think* - it's at work right, and I'm not)
> 
> I believe 4Front provides the only driver for that specific device (it's
> a crippled EMU10k1, probably what could be called a "WinSoundchip")

We have an alpha driver in our CVS tree for this chip as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
