Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317659AbSGUIUV>; Sun, 21 Jul 2002 04:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSGUIUV>; Sun, 21 Jul 2002 04:20:21 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:21771 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317659AbSGUIUU>; Sun, 21 Jul 2002 04:20:20 -0400
Date: Sun, 21 Jul 2002 10:23:14 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Andre Hedrick <andre@linux-ide.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Give Bartlomiej a break!  (Re: Impressions of IDE 98?)
Message-ID: <20020721082314.GE14352@louise.pinerecords.com>
References: <5.1.0.14.2.20020721085320.00b962b0@pop.gmx.net> <5.1.0.14.2.20020721094805.00b9e5c8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020721094805.00b9e5c8@pop.gmx.net>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 46 days, 21:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Sun, 21 Jul 2002, Mike Galbraith wrote:
> >> Since I know spit about IDE/ATA/ATAPI/SCSI, I'll keep my mouth shut and
> >> leave judgement/"voting" to those who fully understand the technical 
> >issues.
> >
> >You probably shouldn't. Technical decisions should be made by technicians,
> >but decisions about the technicians should be made by the human resources
> >dept., and since we claim to be a constitutional monarchy, we might try
> >out a democratic decision...
> 
> No, I'm absolutely sure I'm doing the right thing.

Well you don't necessarily have to be an IDE guru to realize something's
wrong when you see a bloke constantly breaking the subsystem, practically
never fixing it up himself, disappearing for a month w/o saying a word
after having fried 2.5.25 completely and not really caring about what
others have to say about the code.

And you've noticed the IDE 2.4 forward-port, right?

T.
