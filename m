Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUGMIVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUGMIVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUGMIVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:21:02 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8169 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264723AbUGMIMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:12:24 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary
	Kernel	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hk6x8bb43.wl@alsa2.suse.de>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <200407122358.i6CNwvBD003469@localhost.localdomain>
	 <20040712170649.6f4c0c71.akpm@osdl.org>
	 <1089680476.10777.106.camel@mindpipe>  <s5hk6x8bb43.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1089706354.20381.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 04:12:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 03:49, Takashi Iwai wrote:
> At Mon, 12 Jul 2004 21:01:16 -0400,
> Lee Revell wrote:
> > 
> > > Note that this info because available because someone set
> > > /proc/asound/*/*/xrun_debug.  We need more people doing that.
> > > -
> > 
> > This goes back to the need for ALSA documentation.  Someone needs to
> > write some.  This will probably require paying that person.  Hopefully
> > SuSe is working on this, though I suspect I would have heard something.
> 
> Documentation/sound/alsa/Procfile.txt
> 

I should have been more specific, I mean user-level documentation.  All
the necessary information for developers is certainly out there, your
driver guide for example is excellent.  I also didn't mean to imply that
the ALSA developers should do it, they are busy enough already...

Lee

