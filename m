Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269655AbRHIB6w>; Wed, 8 Aug 2001 21:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269653AbRHIB6m>; Wed, 8 Aug 2001 21:58:42 -0400
Received: from merlin.giref.ulaval.ca ([132.203.7.100]:17624 "HELO
	merlin.giref.ulaval.ca") by vger.kernel.org with SMTP
	id <S269670AbRHIB6c>; Wed, 8 Aug 2001 21:58:32 -0400
Date: Wed, 8 Aug 2001 21:58:39 -0400 (EDT)
From: Luc Lalonde <llalonde@giref.ulaval.ca>
To: Florin Andrei <florin@sgi.com>
Cc: Ben Greear <greearb@candelatech.com>, LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Re: [eepro100] Re: Problem with Linux 2.4.7 and builtin eepro on
 Intel's EEA2 motherboard.
In-Reply-To: <997317775.19780.40.camel@stantz.corp.sgi.com>
Message-ID: <Pine.LNX.4.33.0108082157470.18777-100000@merlin.giref.ulaval.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fiorin,

What is your uptime on this machine.  I've come to the same conclusion and
I'm up to 13 days with the Intel e100 driver.

Cheers.


On 8 Aug 2001, Florin Andrei wrote:

> On 07 Aug 2001 13:12:46 -0700, Ben Greear wrote:
> > The driver seems to lock up for a while and then recover...
> >
> > Aug  7 11:55:19 lanf1 last message repeated 5 times
> > Aug  7 11:56:04 lanf1 last message repeated 21 times
> > Aug  7 11:56:07 lanf1 kernel: NETDEV WATCHDOG: eth0: transmit timed out
>
> Same hardware, same problem, only worse: for me, it locks up forever!
>
> Had this problem with several 2.4.x versions, then switched to Intel's
> driver. I'm using the Intel driver now, with 2.4.7, and i have no
> problem.
>
> --
> Florin Andrei
>
>
> _______________________________________________
> eepro100 mailing list
> eepro100@scyld.com
> http://www.scyld.com/mailman/listinfo/eepro100
>

