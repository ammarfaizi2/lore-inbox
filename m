Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVGLEN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVGLEN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVGLENZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:13:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16092 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262342AbVGLENY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:13:24 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <165840000.1121141256@[10.10.2.4]>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
	 <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com>
	 <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 00:13:21 -0400
Message-Id: <1121141602.2632.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 21:07 -0700, Martin J. Bligh wrote:
> 
> --Lee Revell <rlrevell@joe-job.com> wrote (on Monday, July 11, 2005 20:30:59 -0400):
> 
> > On Mon, 2005-07-11 at 14:39 -0600, Chris Friesen wrote:
> >> Lee Revell wrote:
> >> 
> >> > Tickless + sub HZ timers is a win for everyone, the multimedia people
> >> > get better latency, and the laptop people get to run longer.
> >> 
> >> IIRC it's not a win for many systems.  Throughput goes down due to timer 
> >> manipulation overhead.
> > 
> > Makes sense.  Anyway, this whole thread has been pretty hand wavey, I
> > propose that until we see some numbers from the HZ=250 advocates, we
> > leave the default alone.
> 
> Odd. Since I showed you some numbers already ... and nobody from the latency
> side of the argument has come up with any?

Sorry, I have not seen any.  Got a link?

Lee

