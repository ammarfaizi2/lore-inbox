Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263344AbVCDW53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbVCDW53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbVCDWxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:53:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60827 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263205AbVCDVGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:06:09 -0500
Subject: Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <4228C6D9.8010701@tmr.com>
References: <4227085C.7060104@drzeus.cx><4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>  <4228C6D9.8010701@tmr.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 16:06:06 -0500
Message-Id: <1109970367.6710.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 15:36 -0500, Bill Davidsen wrote:
> Nish Aravamudan wrote:
> > On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> > 
> >>I just upgraded to Linux 2.6.11 and the soundcard on my machine went
> >>silent. All volume controls are correct and there are no errors
> >>reported. But no sound coming from the speakers. And here's the kicker,
> >>the headphones work fine!
> >>2.6.10 still works so the bug appeared in one of the patches in between.
> >>The sound card is the one integrated into intels mobile ICH4 chipset.
> > 
> > 
> > There was some discussion of this on LKML a while ago. Are you sure
> > you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
> > alsamixer?
> 
> Is there some option to alsamixer to get those to show up? There's no 
> such entry in the default display (FC3 w/ kernel.org 2.6.1[01]).
> 

Does switching the view with F3 (Playback), F4 (Capture), F5 (All) and
scrolling all the way right help?

If that fails, does "amixer" list them?

Lee

