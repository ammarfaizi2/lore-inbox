Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVHASru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVHASru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVHASrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:47:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42989 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261175AbVHASpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:45:44 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200508011907.32116.jk-lkml@sci.fi>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	 <1122852234.13000.27.camel@mindpipe> <dckikj$e8$1@sea.gmane.org>
	 <200508011907.32116.jk-lkml@sci.fi>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 14:45:40 -0400
Message-Id: <1122921941.15825.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 19:07 +0300, Jan Knutar wrote:
> MPlayer cares more about unbroken sound drivers, since the video needs
> to run at the speed of your sound boards oscillator if you don't want sound
> and video to run at different rates.
> Unfortunately people use an almost random mix of alsa, alsa-lib and .asoundrc
> setups, including me, mplayer through dmix is one jitter-fest, mplayer straight
> to the alsa pcm device works better, but of course using the oss emulation
> seems to work best of all :-)

Because mplayer's ALSA code is broken.

Lee

