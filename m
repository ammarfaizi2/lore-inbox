Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSIFG1o>; Fri, 6 Sep 2002 02:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSIFG1o>; Fri, 6 Sep 2002 02:27:44 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55303
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318348AbSIFG1n>; Fri, 6 Sep 2002 02:27:43 -0400
Date: Thu, 5 Sep 2002 23:25:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@redhat.com>
cc: Thomas Davis <tadavis@lbl.gov>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3
In-Reply-To: <200209052306.g85N6KR24300@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10209052323530.11256-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

I think is addressed for cdroms but maybe the same hammer needs to be
applied to another batch of hardware cruft.

On Thu, 5 Sep 2002, Alan Cox wrote:

> > > > Sep  5 12:11:21 localhost cardmgr[854]: executing: './ide start hde'
> > > > Sep  5 12:11:21 localhost kernel: hde: bad special flag: 0x03
> 
> Ok I can duplicate this but on remove not on insert and it seems to 
> depend on the card the Fujitsu rebadged 340Mb drive does seem to hang my
> thinkpad on remove
> 
> Andre - did the PCMCIA drive and irq masking stuff ever get fully resolved ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

