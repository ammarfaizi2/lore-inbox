Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWFCQiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWFCQiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 12:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWFCQiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 12:38:17 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:3080 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1751316AbWFCQiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 12:38:16 -0400
Subject: Re: [linuxsh-dev] [PATCH] Add support for Yamaha AICA sound on
	SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       Paul Mundt <lethal@linux-sh.org>, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1149347817.28744.12.camel@mindpipe>
References: <1149201071.9032.13.camel@localhost.localdomain>
	 <1149334788.9065.5.camel@localhost.localdomain>
	 <1149347817.28744.12.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 17:38:05 +0100
Message-Id: <1149352686.13122.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 11:16 -0400, Lee Revell wrote:
> On Sat, 2006-06-03 at 12:39 +0100, Adrian McMenamin wrote:
> > On Thu, 2006-06-01 at 23:31 +0100, Adrian McMenamin wrote:
> > > This adds sound for the Yamaha AICA "Super Intelligent Sound
> > > Processor" (PCM) device on the SEGA Dreamcast
> > > 
> > > Signed off by Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > > 
> > I've had no comments back on this - I am thinking of committing to the
> > linux-sh cvs, though it really belongs in ALSA.
> > 
> > Any reason why I shouldn't?
> > 
> 
> Did you fix all of the issues that were raised by Paul and Takashi-san?
> 
> Lee
Those ones that were fixable, yes. At least I think so :)

