Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVGMSJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVGMSJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGMSI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:08:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59321 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262152AbVGMSFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:05:49 -0400
Subject: Re: Linux v2.6.13-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507131045530.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
	 <1121275893.4435.47.camel@mindpipe>
	 <Pine.LNX.4.58.0507131045530.17536@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 14:05:48 -0400
Message-Id: <1121277948.4435.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 10:51 -0700, Linus Torvalds wrote:
> 
> On Wed, 13 Jul 2005, Lee Revell wrote:
> 
> > On Tue, 2005-07-12 at 22:05 -0700, Linus Torvalds wrote:
> > > I think the shortlog speaks for itself.
> > 
> > HZ still defaults to 250.  As was explained in another thread, this will
> > break apps like MIDI sequencers and won't really save much battery
> > power.
> 
> Stop bothering with this, I've seen the thread, and no, I disagree totally 
> with "as explained in another thread". That's simply not true.
> 
> The only thing that is true is that 100Hz is too low for some use, and 
> 1000Hz is too high for some uses. NOBODY has shown that 250Hz isn't good 
> enough, there's only been people whining and complaining and saying it 
> might not be.

OK, point taken, I'm done with this issue as far as LKML is concerned.
Anyone who wants to discuss this further can come over to the
linux-audio-dev list.

Lee

