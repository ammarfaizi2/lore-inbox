Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVGLAsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVGLAsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVGLAqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:46:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9938 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262181AbVGLApx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:45:53 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org, akpm@osdl.org,
       cw@f00f.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       christoph@lameter.org
In-Reply-To: <176640000.1121107087@flay>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 20:45:51 -0400
Message-Id: <1121129151.2632.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 11:38 -0700, Martin J. Bligh wrote:
> >> Lots of people have switched from 2.4 to 2.6 (100 Hz to 1000 Hz) with no impact in
> >> stability, AFAIK. (I only remember some weird warning about HZ with debian woody's
> >> ps).
> >> 
> > 
> > Yes, that's called "progress" so no one complained.  Going back is
> > called a "regression".  People don't like those as much.
> 
> That's a very subjective viewpoint. Realize that this is a balancing
> act between latency and overhead ... and you're firmly only looking
> at one side of the argument, instead of taking a comprimise in the
> middle ...

I won't deny this for a second, I'm 100% arguing from the POV of one of
Alan's 'multimedia weenies'.  I do think that if you propose a big
change the burden of proof is on you to justify it, ideally with some
hard numbers.

Lee

