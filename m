Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130463AbRBARqy>; Thu, 1 Feb 2001 12:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRBARqe>; Thu, 1 Feb 2001 12:46:34 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:47378
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130463AbRBARq3>; Thu, 1 Feb 2001 12:46:29 -0500
Date: Thu, 1 Feb 2001 09:45:59 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <20010201151531.C5706@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.10.10102010945270.16224-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Matthias Andree wrote:

> On Wed, 31 Jan 2001, Andre Hedrick wrote:
> 
> > On Wed, 31 Jan 2001, Paul Flinders wrote:
> > 
> > > Talking of the Promise are there any plans to support re-enabling
> > > of the 2nd channel for boards which have an on-board FastTrak?
> > 
> > FastTrak == Ultra - Fake-RAID
> 
> But Fake-RAID is CHEAP to get two additional UDMA-5 capable channels :-)
> Just jumper for normal ATA/100 mode.

Please create a documnet not and send it to me ;-)


Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
