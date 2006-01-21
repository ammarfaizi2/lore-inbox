Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWAUAad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWAUAad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWAUAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:30:33 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:6339 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932301AbWAUAad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:30:33 -0500
Subject: Re: RFC: OSS driver removal, a slightly different approach
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       =?ISO-8859-1?Q?Fr=E9d=E9ric?= "L. W. Meunier" <2@pervalidus.net>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       perrye@linuxmail.org
In-Reply-To: <Pine.LNX.4.61.0601201519050.22940@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de>
	 <Pine.LNX.4.64.0601191815550.1300@dyndns.pervalidus.net>
	 <1137703548.32195.25.camel@mindpipe>
	 <200601192203.11032.s0348365@sms.ed.ac.uk>
	 <Pine.LNX.4.61.0601201519050.22940@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 19:30:30 -0500
Message-Id: <1137803431.3241.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 15:19 +0100, Jan Engelhardt wrote:
> >> > Why aren't drivers like SOUND_TVMIXER listed ? That one isn't
> >> > in ALSA, but there's a port at
> >> > http://www.gilfillan.org/v3tv/ALSA/ . It's now the only I
> >> > enable in OSS.
> >>
> >> Grr... why would someone bother to write a driver then not submit it or
> >> even tell the ALSA maintainers?
> 
> Fear of not getting it included?

I doubt anyone so thin skinned would make it as far as being able to
write a working Linux driver ;-)

Anyway, what's to fear?  The worst that will happen is that the kernel
maintainers will request some changes.

Lee

