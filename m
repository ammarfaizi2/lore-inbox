Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263635AbUDUTWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUDUTWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDUTWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:22:32 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:58378 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263370AbUDUTWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:22:30 -0400
Date: Wed, 21 Apr 2004 20:22:28 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Jean Delvare <khali@linux-fr.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Permissions on include/video/neomagic.h
In-Reply-To: <200404212056.24315.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0404212022160.9207-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Never mind then :-)


On Wed, 21 Apr 2004, Bartlomiej Zolnierkiewicz wrote:

> On Wednesday 21 of April 2004 20:45, James Simmons wrote:
> > > > > In linux-2.6.5.tar, include/video/neomagic.h has permissions 0640.
> > > > > It obviously should be 0644.
> > > >
> > > > I'm preparing new neofb patch for Andrew Morton. They will fix this.
> > >
> > > Just curious... How can a patch change file permissions?
> >
> > If it is a BK patch I assume that would fix it.
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@4082d4a3XJbVYeEqSdkkuhnyiEJ4Ww?nav=index.html|ChangeSet@-3d
> 
> Fix permission problem on include/video/neomagic.h
> Change mode to -rw-r--r--
> 
> Just FYI ;)
> 
> 

