Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWE1V2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWE1V2H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 17:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWE1V2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 17:28:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54416 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750894AbWE1V2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 17:28:06 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060528204558.GR13513@lug-owl.de>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
	 <1148846131.27461.14.camel@mindpipe>  <20060528204558.GR13513@lug-owl.de>
Content-Type: text/plain
Date: Sun, 28 May 2006 17:27:39 -0400
Message-Id: <1148851660.27461.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 22:45 +0200, Jan-Benedict Glaw wrote:
> On Sun, 2006-05-28 15:55:29 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Sun, 2006-05-28 at 20:12 +0200, Arjan van de Ven wrote:
> > > Also... why would there really be a need for such a way? Not for
> > > building anything for sure.... it's for the human. And the human seems
> > > to just find it already (and again the boot file works well in practice
> > > it seems)
> > 
> > Debugging.  When a new Linux user files a "no sound" ALSA bug report I
> > need to find out whether they have any known broken options enabled,
> > like USB bandwidth checking or the OSS USB midi/audio drivers.  If we
> > have to go back and forth figuring out which distro they have and where
> > the config is they are that much more likely to give up and go back to
> > Windows.
> 
> ...which isn't always the worst solution to the problem. If some guy
> doesn't want to jump through the loops to figure out what's actually
> broken, Windows may be a good solution for them. "World domination"
> also means "dominated by the world's problems," so I tend to go a step
> back from time to time:-)

Yes, if it were a perfect world and we had access to all the hardware
specs like Microsoft does, we would not need these users' help.  But the
users have access to a lot more hardware than the developers do and
trial and error is often the only solution.

If they give up and go back to Windows we may never support their
hardware correctly.

Lee

