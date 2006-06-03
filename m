Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWFCXCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWFCXCF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 19:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWFCXCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 19:02:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52164 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751819AbWFCXCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 19:02:04 -0400
Subject: Re: Alsa sound vs OSS with wine and riven
From: Lee Revell <rlrevell@joe-job.com>
To: Stephen.Clark@seclark.us
Cc: wine-devel-request@winehq.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <448213DF.4030506@seclark.us>
References: <4481E816.4090600@seclark.us>
	 <1149367697.28744.45.camel@mindpipe>  <448213DF.4030506@seclark.us>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 19:02:01 -0400
Message-Id: <1149375722.28744.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 18:57 -0400, Stephen Clark wrote:
> Lee Revell wrote:
> 
> >On Sat, 2006-06-03 at 15:50 -0400, Stephen Clark wrote:
> >  
> >
> >>Hello,
> >>
> >>I have been working to get "Riven" the sequel to Myst to work with
> >>the 
> >>latest wine from cvs on the latest FC5. It works and the sound is
> >>almost perfect with 
> >>OSS, but is totally screwed up when I use ALSA, I don't know whether
> >>this is a WINE or Linux 
> >>issue, so I am cross posting to both lists.
> >>    
> >>
> >
> >Does it work with ALSA's OSS emulation?
> >
> >Lee
> >
> >
> >  
> >
> Actually looking at the .config file it looks like it is using OSS 
> emulation - not real OSS.

Then it's a bug in Wine's ALSA driver.

Lee

