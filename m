Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTD2NMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTD2NMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:12:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21390 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261970AbTD2NMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:12:53 -0400
Date: Tue, 29 Apr 2003 09:26:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Martin List-Petersen <martin@list-petersen.dk>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       "David S. Miller" <davem@redhat.com>, bas.mevissen@hetnet.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Broadcom BCM4306/BCM2050  support
In-Reply-To: <1051618337.3eae6c218bd3c@roadrunner.hulpsystems.net>
Message-ID: <Pine.LNX.4.53.0304290851030.23672@chaos>
References: <1051596982.3eae18b640303@roadrunner.hulpsystems.net>
 <1051614381.21135.5.camel@rth.ninka.net> <3EAE644A.2000101@gmx.net>
 <1051618337.3eae6c218bd3c@roadrunner.hulpsystems.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003, Martin List-Petersen wrote:

> Citat Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>:
>
> > > So don't blame the vendors on this one, several of them would love
> > > to publish drivers public for their cards, but simply cannot with
> > > upsetting federal regulators.
> >
> > /me wants binary only driver for these cards to build opensource driver
> > with ability to set "interesting" frequency range.
> >
>
> It's there for Windows :) So ...

Contrary to popular opinion, there is no FCC regulation prohibiting
one from receiving some particular frequency. There is, however, a
federal law prohibiting the disclosure of a radio message by a
third party. This means that the media, or even law enforcement
can't listen to a private radio (cell phone) conversation and
then disclose its content. At one time, cell phones used FM
at 960 MHz. This could be readily received by receivers designed
for Amateur Radio use. For a time, the FCC refused to Type Approve
receivers that cover these frequencies. However, most Hams know
how to fix their receivers so they can receive whatever they want
and Type Approval was only required for receivers that were designed
to be sold. You could build anything you want for yourself. This
refusal to Type Approve receivers was a trick to make the usual
receiver owner think that there was some dumb regulation when,
in fact, under the Communications Act of 1934 (as amended), there
can't be such a regulation without creating a new public law, which
hasn't happened and probably will not.

Recently, some broadcast satellite companies have tried to
get the FCC to declare that their transmissions are private
and unauthorized reception should be unlawful. The FCC has
continually postponed any such declaration because, if once
broadcast, a radio signal doesn't become public, then anybody
could sue every radio transmitter operator to prevent the
trespass of "their" signals onto private property.
You can't have it both ways, either radio signals are public
and, therefore cannot commit a trespass, or they are private
and can.

But, unlike some other countries regulators, the FCC has
steadfastly refused to allow broadcasters, even satellite
broadcasters, to pursue such extortion. Basically, once
a signal leaves an antenna, it becomes public property.

The same is not true for cable and "guided waves". Satellite
broadcasters have not been able to convince the FCC that
their transmissions are "guided waves". However, some private
RF link companies signals, including some that use satellites,
are considered "guided waves" and cannot be used without
permission.

Various commercial interests have convinced governments of
many other countries that they "own" their radio signals and
therefore different regulations exist in many other countries.
In the UK, for instance, one has to purchase a license to
use a receiver (you know, some Sony Walkman). This is, in my
opinion, extremely repressive. It would be nice for somebody
to start suing the BBC (and others) to recover damages for
the criminal trespass of "their" radio signals onto private
property. After a few such lawsuits, the ownership of such
broadcast signals would revert to the public, just like in
the US.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

