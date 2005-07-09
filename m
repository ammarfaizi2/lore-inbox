Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVGISnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVGISnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVGISmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:42:47 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8871 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261682AbVGISlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:41:09 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <20050709203920.394e970d.diegocg@gmail.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 09 Jul 2005 14:41:05 -0400
Message-Id: <1120934466.6488.77.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 20:39 +0200, Diego Calleja wrote:
> El Sat, 09 Jul 2005 14:16:31 -0400,
> Lee Revell <rlrevell@joe-job.com> escribió:
> 
> > I still think you're absolutely insane to change the default in the
> > middle of a stable kernel series.  People WILL complain about it.
> 
> 
> Lots of people have switched from 2.4 to 2.6 (100 Hz to 1000 Hz) with no impact in
> stability, AFAIK. (I only remember some weird warning about HZ with debian woody's
> ps).
> 

Yes, that's called "progress" so no one complained.  Going back is
called a "regression".  People don't like those as much.

Lee

