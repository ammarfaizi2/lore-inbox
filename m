Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTFYSap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbTFYSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:30:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9346 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264957AbTFYSah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:30:37 -0400
Date: Wed, 25 Jun 2003 20:44:19 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SOLVED - Testing IDE-TCQ and Taskfile - doesn't work nicely:)
In-Reply-To: <20030625182210.GI29233@lug-owl.de>
Message-ID: <Pine.SOL.4.30.0306252040570.11992-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:

> On Wed, 2003-06-25 01:08:13 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> wrote in message <Pine.SOL.4.30.0306250107180.17106-100000@mion.elka.pw.edu.pl>:
> > On Wed, 25 Jun 2003, Jan-Benedict Glaw wrote:
> > > On Tue, 2003-06-24 15:44:36 +0200, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> > > wrote in message <Pine.SOL.4.30.0306241543050.23584-100000@mion.elka.pw.edu.pl>:
> > >
> > > > Corrected patch below...
> > >
> > > Taking this 2nd IDE patch, my boot-up looks as shown below. I still have
> >
> > Thanks for testing, it looks okay now.
> >
> > > to test the taskfile thing again, but I cannot find my girlfriends
> > > digital camera right now:)
>
> Found the cam, downloaded any old pics, recompiled with taskfile I/O and
> - nothing. 2.5.73 + your second IDE patch do work flawlessly on my old
> box. The "clack     clack    clack" went away is if had never been
> there...

:-)

> So - thanks a lot for looking at my problem. Please feed your patch to
> Linus as it seems to actually solve (at least my) problems.
>
> However, allow me to ask why this occured never bevore (for other
> people)? Do they all have only one drive? Does nobody use TCQ? Nobody
> with old hardware (though, your patch hasn't touched the core PIIX
> parts...)?

nobody is stupid^H^Hbrave enough to use TCQ ;-)

Thanks,
--
Bartlomiej

> MfG, JBG
>
> --
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
>       ret = do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

