Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161470AbWALXcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbWALXcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWALXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:32:18 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:14055 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161470AbWALXcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:32:17 -0500
Subject: Old hardware (was Re: [PATCH] Prevent trident driver from grabbing
	pcnet32 hardware)
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060112225205.GZ29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com>
	 <43C6ADDE.5060904@liberouter.org>
	 <20060112200735.GD5399@granada.merseine.nu>
	 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
	 <1137105731.2370.94.camel@mindpipe>  <20060112225205.GZ29663@stusta.de>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 18:32:14 -0500
Message-Id: <1137108735.2370.110.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 23:52 +0100, Adrian Bunk wrote:
> On Thu, Jan 12, 2006 at 05:42:10PM -0500, Lee Revell wrote:
> > On Thu, 2006-01-12 at 23:00 +0100, Adrian Bunk wrote:
> > > CYBER5050 is discussed in ALSA bug #1293 (tester wanted).
> > 
> > OK I set that bug to FEEDBACK, but it's open 5 months now and no
> testers
> > are forthcoming.  I think if we don't find one as a result of this
> > thread we can assume no one cares about this hardware anymore.
> 
> The majority of Linux users doesn't read linux-kernel...
> 
> We might find users after the OSS driver is deprecated in a released 
> kernel, or perhaps some months after it's removed from the kernel.
> 
> This would match my current experiences regarding my suggested
> removal 
> of some OSS drivers. 

While we're on the topic, what *is* the best place to solicit hardware
donations for purposes of driver development?

I ask because the snd-nm256 driver is one that we know users have, but
the ALSA driver has never worked (sound OK but the machine frequently
locks up IIRC, see ALSA bug #305), and the device has been unavailable
for years.  Basically these users are screwed if we can't get a hardware
sample, but I think that might mean someone has to give us a whole
laptop.

Lee

