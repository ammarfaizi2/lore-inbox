Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270772AbTHJXmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270804AbTHJXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:42:55 -0400
Received: from [66.212.224.118] ([66.212.224.118]:8206 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270772AbTHJXmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:42:53 -0400
Date: Sun, 10 Aug 2003 19:31:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: jlnance@unity.ncsu.edu
Cc: Eric Blade <eblade@blackmagik.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2/3 ESS1371 Audio
In-Reply-To: <20030810232856.GA13070@ncsu.edu>
Message-ID: <Pine.LNX.4.53.0308101930450.31799@montezuma.mastecende.com>
References: <3F356881.9070206@blackmagik.dynup.net> <20030810232856.GA13070@ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 jlnance@unity.ncsu.edu wrote:

> On Sat, Aug 09, 2003 at 05:32:49PM -0400, Eric Blade wrote:
> > In 2.6.0-test1, the ESS1371 module stopped giving me sound output when 
> 
> FWIW, I compiled ESS1371 support into the kernel and it is found during
> boot.  However, no sound comes from the card.  I did an strace of realplayer
> and it is sucessfully opening /dev files for the device.  I do not know
> when this started, as I have not been following 2.6 development closely.
> 
> I seem to remember someone having this problem in the past and it turned
> out the be that the volume was turned down.  I would have thought that
> realplayer would have turned it back up, so that probably is not the
> problem.

Is this ALSA or OSS?

	Zwane

