Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135538AbRBERa7>; Mon, 5 Feb 2001 12:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135540AbRBERat>; Mon, 5 Feb 2001 12:30:49 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9479
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135538AbRBERac>; Mon, 5 Feb 2001 12:30:32 -0500
Date: Mon, 5 Feb 2001 09:30:04 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't
 work)
In-Reply-To: <20010205144043.H849@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10102050928530.30462-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Ingo Oeser wrote:

> On Mon, Feb 05, 2001 at 01:34:24AM -0200, Rogerio Brito wrote:
> > 	Well, this has nothing to do with the above, but is there any
> > 	utility or /proc entry that lets me say to my CD drive that it
> > 	should not work at full speed?
> 
> /proc/ide/hdX/settings ? The (current,init)_speed settings there?
> 
> Give it a try at least ;-)

That is the ATA transfer rate between the device and the host only.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
