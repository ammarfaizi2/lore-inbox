Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbTAMQek>; Mon, 13 Jan 2003 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267842AbTAMQek>; Mon, 13 Jan 2003 11:34:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19884 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267843AbTAMQeb>;
	Mon, 13 Jan 2003 11:34:31 -0500
Date: Mon, 13 Jan 2003 17:43:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113164305.GZ14017@suse.de>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <1042400219.1208.29.camel@RobsPC.RobertWilkens.com> <20030112195347.GJ3515@louise.pinerecords.com> <1042401817.1209.54.camel@RobsPC.RobertWilkens.com> <1042472605.5404.72.camel@pc-16.office.scali.no> <20030113154954.GR14017@suse.de> <1042475145.5404.86.camel@pc-16.office.scali.no> <20030113162638.GY14017@suse.de> <1042476101.5399.92.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042476101.5399.92.camel@pc-16.office.scali.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13 2003, Terje Eggestad wrote:
> > > I have the console on a serial port, and a terminal server. With kdb,
> > > you can enter the kernel i kdb even when deadlocked.
> > 
> > Even if spinning with interrupt disabled?
> 
> Haven't painted myself into that corner yet. Doubt it, very much.

These are the nasty hangs, total lockup and no info at all if it wasn't
for the nmi watchdog triggering. That alone is reason enough for me :-)

-- 
Jens Axboe

