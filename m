Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSF1SI5>; Fri, 28 Jun 2002 14:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317475AbSF1SI4>; Fri, 28 Jun 2002 14:08:56 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48388
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317474AbSF1SIz>; Fri, 28 Jun 2002 14:08:55 -0400
Date: Fri, 28 Jun 2002 11:11:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Status of write barrier support for 2.4?
In-Reply-To: <20020628200203.A777@suse.de>
Message-ID: <Pine.LNX.4.10.10206281108100.2888-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

I just got crapped all over trying to get us "write barrier" opcodes :-/.
However I do have the start of a draft to submit soon.  I could not piggy
back of FUA by MicroSoft last week.

So how did the talk go at OLS for the IDE roadmap to destruction go?
I could not attend, as I was doing other stuff associated with the
industry.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 28 Jun 2002, Jens Axboe wrote:

> On Thu, Jun 27 2002, Matthias Andree wrote:
> > Hi,
> > 
> > what is the status of write barrier support in Linux?
> 
> We have stable support for IDE (ie block layer barrier support works,
> IDE implementation works). I doubt we'll ever do 2.4 SCSI support,
> it would be too invasive to really make it safe.
> 
> > Is there a web page that documents patches and status?
> 
> Not to my knowledge.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

