Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUBGQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266955AbUBGQR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:17:57 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53475 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266474AbUBGQR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:17:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Tomt <andre@tomt.net>
Subject: Re: Linux 2.6.3-rc1
Date: Sat, 7 Feb 2004 17:22:10 +0100
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <4024BCE4.2060600@tomt.net>
In-Reply-To: <4024BCE4.2060600@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402071722.10242.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 of February 2004 11:24, Andre Tomt wrote:
> Linus Torvalds wrote:
> > Ok, this is another big merge of a number of pending patches, although to
> > some degree the patches have now moved "outwards" from the core, and most
> > of them are in driver land.
> >
> > There's a lot of network driver updates (have been in -mm and Jeff's
> > testing trees for a while), and Al Viro has been fixing up not just
> > network drivers, but also cursing over parport interfaces ;)
> >
> > Andrew's patches are all over, from fixing warnings with new versions of
> > gcc to merging things like the ppc updates he had in his tree, and
> > everything in between.
> >
> > On and a big ALSA update, along with SCSI updates (big qla update, for
> > example).
> >
> > So let's calm down and make sure all the updates are ok.
>
> pdc202xx_old OOPS's on load in case of completely modular IDE (core and
> pci ide drivers). I have yet to capture the OOPS, as someone has just
> ran away with the one serial cable over here.
>
> If we're lucky Bart knows what's missing without the trace ( :-) ! ). If
> not, I'll see if I can get netconsole up and running.

:-(

Please try to capture this OOPS.

