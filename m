Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265564AbUEZMpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265564AbUEZMpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265566AbUEZMpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:45:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265564AbUEZMpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:45:16 -0400
Date: Wed, 26 May 2004 08:44:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Zenaan Harkness <zen@freedbms.net>
cc: debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: drivers DB and id/ info registration
In-Reply-To: <1085573236.2213.77.camel@zen8100a.freedbms.net>
Message-ID: <Pine.LNX.4.53.0405260835370.858@chaos>
References: <1085542706.2908.25.camel@zen8100a.freedbms.net> 
 <20040526065447.GA32304@dat.etsit.upm.es>  <200405260918.51589@fortytwo.ch>
  <1085566079.2522.54.camel@zen8100a.freedbms.net>  <1085571316.906.3.camel@localhost>
 <1085573236.2213.77.camel@zen8100a.freedbms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004, Zenaan Harkness wrote:

> On Wed, 2004-05-26 at 21:35, Wouter Verhelst wrote:
> > Op wo 26-05-2004, om 12:07 schreef Zenaan Harkness:
> > > I develop widget X.
> > >
> > > I contact microsoft and have X incorporated into windows.
> >
> > Rotfl.
>
> OK, bad assumption.
>
> The only reason I say that is that so many devices work
> "seamlessly" with MSW*
>
>  - recently I read a review on the X-Arcade retro joystick
> controllers (those heavy "for cabinets and MAME" things).
> The reviewer just plugged it in and Windows literally popped
> up with a dialog telling the "end user recognizable" name of
> the device.
>
>  - a year or so back, my brother bought a "blue eye" USB
> external 2.5" HDD (really nice looking thing) and on his
> XP box it auto added a new drive (E: or whatever). Seamless.
>
> So how come devices tend to just plug and play when
> used with Windows (USB HDDs, audi cards, logitec gear)?
>
> Will a "visible"/ centralized location where manufacturers
> can submit info on their devices (for free software kernels)
> help to get us closer to the "front line" of device support?
>
> thanks
> zen

M$ has a whole division dedicated to plug-and-pray developers.
When their USB disk, camera, or whatever gets "approved", its
name is put into W$ even without installing any "drivers".
That's why W$ is so large. It would be good if somebody
started to do something like that for Linux, perhaps a
database from which configuration stuff could be extracted.
It's not a kernel issue, so some distribution really should
take it up.

Of course, the work needs to be done correctly so you don't
get the M$ problem of; "Everything was working until I installed
my new printer...." Whereupon you install everything from a
newly-formatted hard-disk, all over again, installing the
new printer first!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


