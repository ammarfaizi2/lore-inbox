Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVDDT12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVDDT12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVDDT11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:27:27 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:59485 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261341AbVDDT1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:27:16 -0400
X-ME-UUID: 20050404192715287.462911C00216@mwinf0812.wanadoo.fr
Date: Mon, 4 Apr 2005 21:24:04 +0200
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404192404.GA1829@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182144.GB31055@pegasos> <1112641971.4342.8.camel@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1112641971.4342.8.camel@cthulhu>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 08:12:48PM +0100, Ian Campbell wrote:
> On Mon, 2005-04-04 at 20:21 +0200, Sven Luther wrote:
> > On Mon, Apr 04, 2005 at 10:51:30AM -0700, Greg KH wrote:
> > > Then let's see some acts.  We (lkml) are not the ones with the percieved
> > > problem, or the ones discussing it.
> 
> [...]
> 
> > All i am asking is that *the copyright holders* of said firmware blobs put a
> > little comment on top of the files in question saying, all this driver is
> > GPLed, except the firmware blobs, and we give redistribution rights to said
> > firmware blobs.
> 
> I think what Greg may have meant[0] was that if it bothers you, then you
> should act by contacting the copyright holders privately yourself in
> each case that you come across and asking them if you may add a little
> comment etc, and then submit patches once you have their agreement.

Yeah, that is step 3, i mailed LKML, because maybe you would have some useful
coment, or some of you who wrote said code may have contacts or something with
the copyright holders, or some other insight. I also didn't want this to cause
a problem if i blundered in some tense relationship or whatever.

For example, the tg3 driver says : 

 * tg3.c: Broadcom Tigon3 ethernet driver.
 *
 * Copyright (C) 2001, 2002, 2003, 2004 David S. Miller (davem@redhat.com)
 * Copyright (C) 2001, 2002, 2003 Jeff Garzik (jgarzik@pobox.com)
 * Copyright (C) 2004 Sun Microsystems Inc.
 *
 * Firmware is:
 *      Copyright (C) 2000-2003 Broadcom Corporation.

There is no contact for either sun or broadcom, but i believe that Jeff or
David may know where this firmware blob may (or not) come from.

Friendly,

Sven Luther


