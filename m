Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUDYL3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUDYL3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 07:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDYL3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 07:29:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32945 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261530AbUDYL3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 07:29:00 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       fedora-devel-list@redhat.com
Subject: Re: Update on problems creating iteraid driver disk
Date: Sun, 25 Apr 2004 13:28:18 +0200
User-Agent: KMail/1.5.3
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <408B270C.1050201@gear.dyndns.org> <1082890181.24757.12.camel@m64.net81-64-154.noos.fr>
In-Reply-To: <1082890181.24757.12.camel@m64.net81-64-154.noos.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404251328.18467.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 of April 2004 12:49, Nicolas Mailhot wrote:
> Le dim, 25/04/2004 à 12:48 +1000, Paul Gear a écrit :
> > Hi folks,
> >
> > A while back i posted about trying to create iteraid driver disks for
> > FC1.  With the help of David Kewley's instructions
> > (http://www.klab.caltech.edu/~kewley/driverdisk/dd.html) on using Doug
> > Ledford's driver kit (http://people.redhat.com/dledford/), i managed to
> > create a proper driver disk.
>
> Frankly if you really want to bother with ite hardware (the SII680 is
> available here for the same price and is perfectly supported under
> Linux) you should focus on getting their driver inside the kernel.org

ITE docs are _publicly_ available unlike SiI ones.

> sources.

Yep.

> ie make diffs, submit them to LKM, make the changes people request, etc
> (ite is GPLed if  I remember well).
>
> This may seem more difficult but remember the kernel is a moving
> target : after six months you'll have spent more energy getting this
> out-of-tree driver work than getting it in-tree now.

Well, I still have ITE (libata!) driver on my TODO,
but due to lack of free drives and time it is not yet done.

Cheers.

