Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbTC1A6U>; Thu, 27 Mar 2003 19:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbTC1A6U>; Thu, 27 Mar 2003 19:58:20 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17835 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261834AbTC1A6S>; Thu, 27 Mar 2003 19:58:18 -0500
Date: Fri, 28 Mar 2003 02:09:24 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
In-Reply-To: <1048811262.3953.14.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0303280206450.27389-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Mar 2003, Alan Cox wrote:

> On Fri, 2003-03-28 at 00:10, Bartlomiej Zolnierkiewicz wrote:
> > > The IDE taskfile stuff for I/O is known broken. Thats why it
> > > is currently disabled. I plan to keep it that way until 2.7
> >
> > What is broken?
> > It works just as good as standard code
> > (with taskfile fixes from ide-pio-1 and ide-pio-2 patches)
> > ...or I am missing something?
>
> I hadn't realised you had rewritten all the PIO side of it when
> I wrote that. Looks like the revised plan is "pure taskfile for
> 2.6 care of Bartlomiej"

Okay, there is still plenty fixmes...

