Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSAFMtY>; Sun, 6 Jan 2002 07:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287852AbSAFMtE>; Sun, 6 Jan 2002 07:49:04 -0500
Received: from frank.gwc.org.uk ([212.240.16.7]:18703 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S287850AbSAFMs7>;
	Sun, 6 Jan 2002 07:48:59 -0500
Date: Sun, 6 Jan 2002 12:48:56 +0000 (GMT)
From: Alistair Riddell <ali@gwc.org.uk>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: no highmem with 2GB RAM?
In-Reply-To: <20020106111737.C8673@suse.de>
Message-ID: <Pine.LNX.4.21.0201061247520.4200-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Jens Axboe wrote:

> On Sat, Jan 05 2002, Alistair Riddell wrote:
> > I have a couple of SMP i386 boxes with 2GB RAM. They suffer from poor
> > performance due to block IO page bouncing with highmem enabled. I have
> > tried the block-highmem patch but this causes occasional oopses and even
> > panics under high IO load.
> 
> Well thanks for sending in a bug report on that. Mind doing so?

I did send in a report a while back to the list and yourself but it was
ignored... I will try to gather together the details and/or reproduce it
and send details again.

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 446 6070    Fax: +44 131 452 8594
Microsoft - because god hates us

