Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWAEUjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWAEUjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAEUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:39:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48070 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932176AbWAEUjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:39:17 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Tomasz Torcz <zdzichu@irc.pl>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <CE222A69-A124-46C9-8139-BB579F91B9FA@dalecki.de>
References: <20050726150837.GT3160@stusta.de>
	 <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
	 <200601031629.21765.s0348365@sms.ed.ac.uk>
	 <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de>
	 <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de>
	 <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com>
	 <s5hpsn8md1j.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr>
	 <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
	 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
	 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de>
	 <1136486021.31583.26.camel@mindpipe>
	 <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de>
	 <1136491503.847.0.camel@mindpipe>
	 <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de>
	 <1136492896.847.21.camel@mindpipe>
	 <CE222A69-A124-46C9-8139-BB579F91B9FA@dalecki.de>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:39:13 -0500
Message-Id: <1136493553.847.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 21:32 +0100, Marcin Dalecki wrote:
> On 2006-01-05, at 21:28, Lee Revell wrote:
> 
> > We close dozens of bugs each week.  I personally closed more than 50
> > last week (most had been fixed months ago).  90% of ALSA development
> > happens through the bug tracker.
> 
> ...
> 
> > Check out the linux-audio-dev and linux-audio-user archives.  ALSA has
> > been working perfectly for all of those users for years.
> 
> You are aware of how self contradicting this sounds?!
> 

Not at all.  By "working perfectly" I obviously didn't mean that ALSA
hasn't had a bug in years - I meant that when we DO get an actionable
bug report we fix it.

Lee

