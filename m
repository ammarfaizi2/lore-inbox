Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbULCWps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbULCWps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbULCWps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:45:48 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44416
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262435AbULCWpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:45:42 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andre Tomt <andre@tomt.net>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
In-Reply-To: <41AF76E0.5050907@tomt.net>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
	 <1101985759.13353.102.camel@tglx.tec.linutronix.de>
	 <1101995280.13353.124.camel@tglx.tec.linutronix.de>
	 <20041202164725.GB32635@dualathlon.random>
	 <20041202085518.58e0e8eb.akpm@osdl.org>
	 <20041202180823.GD32635@dualathlon.random>
	 <1102013716.13353.226.camel@tglx.tec.linutronix.de>
	 <20041202110729.57deaf02.akpm@osdl.org>
	 <1102014493.13353.239.camel@tglx.tec.linutronix.de>
	 <20041202112208.34150647.akpm@osdl.org>
	 <1102015450.13353.245.camel@tglx.tec.linutronix.de>
	 <41AF76E0.5050907@tomt.net>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 23:45:40 +0100
Message-Id: <1102113940.13353.295.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 21:11 +0100, Andre Tomt wrote:
> Thomas Gleixner wrote:
> > On Thu, 2004-12-02 at 11:22 -0800, Andrew Morton wrote:
> >>You can issue sysrq commands over serial consoles too.
> > 
> > I know, but the console and the reset button are 150km away. When I dial
> > into the machine or try to connect via the network, I cannot connect
> > with the current kernels. Neither 2.4, because the fork fails, nor 2.6
> > because oom killed sshd. So I cannot send anything except a service man,
> > who drives 150km to hit sysrq-F or the reset button.
> 
> Get one of those terminal server/concentrators that export the serial 
> consoles over IP. Or one of those KVM-over-IP extenders. Worth every penny.

Makes totally sense. 

I add 1000$ equipment to a 300$ embedded box because there is a software
bug.

Is it possible that we are living in a different universe ?

tglx


