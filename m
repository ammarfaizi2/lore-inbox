Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbUACH4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 02:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUACH4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 02:56:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37382
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262784AbUACH4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 02:56:08 -0500
Date: Fri, 2 Jan 2004 23:53:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Christophe Saout <christophe@saout.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CPRM ?? Re: Possibly wrong BIO usage in ide_multwrite
In-Reply-To: <20040102113018.GP5523@suse.de>
Message-ID: <Pine.LNX.4.10.10401022352031.31033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

Cute, so when will it be Jens Axboe <axboe@novell.com>.

When I ask for your opinion I will reach around and wipe for it :-)

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 2 Jan 2004, Jens Axboe wrote:

> On Thu, Jan 01 2004, Andre Hedrick wrote:
> > 
> > Christophe,
> > 
> > I am sorry but adding in a splitter to CPRM is not acceptable.
> > Digital Rights Management in the kernel is not acceptable to me, period.
> > 
> > Maybe I have misread your intent and the contents on your website.
> > 
> > Device-Mappers are one thing, intercepting buffers in the taskfile FSM
> > transport is another.  This stinks of CPRM at this level, regardless of
> > your intent.  Do correct me if I am wrong.
> 
>        0   2   4   6   8   10
>                         /
>                        /
>                       /
>                      /
>                     /
>                    /
>                   /
>            PARANOIA-METER
> 
> -- 
> Jens Axboe
> 

