Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbTLKJ1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTLKJ1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:27:36 -0500
Received: from AGrenoble-101-1-4-17.w217-128.abo.wanadoo.fr ([217.128.202.17]:3213
	"EHLO awak") by vger.kernel.org with ESMTP id S264561AbTLKJ1f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:27:35 -0500
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Witukind <witukind@nsbm.kicks-ass.org>
Cc: mru@kth.se, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031210210614.625ccfcc.witukind@nsbm.kicks-ass.org>
References: <1070963757.869.86.camel@nomade>
	 <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
	 <20031209183001.GA9496@kroah.com> <yw1xvfop257d.fsf@kth.se>
	 <1071039765.1790.94.camel@nomade>
	 <20031210210614.625ccfcc.witukind@nsbm.kicks-ass.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1071134837.1789.123.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 10:27:18 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 10/12/2003 à 21:06, Witukind a écrit :
> On Wed, 10 Dec 2003 08:02:46 +0100
> Xavier Bestel <xavier.bestel@free.fr> wrote:
> > Come on ... the stock kernel from your distribution will do the
> > modprobe for you when you access the floppy, I'm sure you're skilled
> > enough to configure your own kernel to do the same.
> > And if you don't want to recompile, just chmod +s modprobe - on your
> > small machine which needs to save 60k, I bet you're the only user. Or
> > use sudo.
> > 
> > 	Xav
> 
> I was expecting this kind of reply. Like "if you have an older hardware you
> can fuck off".

Wow ... how can you understand this in my text ? Because I'm guessing he
is the only user on his machine ? This has nothing to do with small
machines, but with system configuration: load on-demand may be done
without devfs.
Well, I wish do apologize to Måns if he thought I was ridiculing his
hardware. Just take out the last sentence with "modprobe" if it bothers
you.

	Xav

