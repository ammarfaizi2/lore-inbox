Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVGLPNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVGLPNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGLPLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:11:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61840 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261502AbVGLPKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:10:17 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <15890000.1121180902@[10.10.2.4]>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
	 <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com>
	 <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]>
	 <1121141602.2632.31.camel@mindpipe>  <188690000.1121142633@[10.10.2.4]>
	 <1121178300.2632.51.camel@mindpipe>  <14170000.1121180207@[10.10.2.4]>
	 <1121180403.2632.59.camel@mindpipe>  <15890000.1121180902@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 11:10:13 -0400
Message-Id: <1121181014.2632.67.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 08:08 -0700, Martin J. Bligh wrote:
> Well, looking forward, you'll have sub-HZ timers, so none of this will
> matter. Actually, looking at the above, 150 seems perfectly reasonable
> to me, but 300 seems to be close enough. I'll run some numbers on both.
> 
> >From your above email, I'm more convinced than ever that lowering HZ is
> the right thing to do ...

Which we can live with of course, I just wanted to make sure people were
aware of the multimedia side of the argument.

Lee

