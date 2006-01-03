Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWACThU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWACThU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWACThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:37:19 -0500
Received: from gate.perex.cz ([85.132.177.35]:48283 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932501AbWACThS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:37:18 -0500
Date: Tue, 3 Jan 2006 20:37:16 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <1136316640.4106.26.camel@unreal>
Message-ID: <Pine.LNX.4.61.0601032036250.9362@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>  <200601031522.06898.s0348365@sms.ed.ac.uk>
 <20060103160502.GB5262@irc.pl>  <200601031629.21765.s0348365@sms.ed.ac.uk>
  <20060103170316.GA12249@dspnet.fr.eu.org>  <1136312901.24703.59.camel@mindpipe>
 <1136316640.4106.26.camel@unreal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Thomas Sailer wrote:

> On Tue, 2006-01-03 at 13:28 -0500, Lee Revell wrote:
> 
> > Please provide a reproducible test case where an app *that we have the
> > source code for* works with native OSS or the in kernel /dev/dsp OSS
> > emulation and fails with the aoss/alsa-lib/userspace OSS emulation and
> > it will be fixed ASAP.
> 
> I didn't know AOSS, but http://www.baycom.org/~tom/ham/soundmodem/ fails
> with ALSA's kernel OSS emulation.

Anyone reported that? Also what's the exact bug symptom?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
