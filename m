Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129407AbRBAOP5>; Thu, 1 Feb 2001 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbRBAOPr>; Thu, 1 Feb 2001 09:15:47 -0500
Received: from p3EE3CA62.dip.t-dialin.net ([62.227.202.98]:53511 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129407AbRBAOPg>; Thu, 1 Feb 2001 09:15:36 -0500
Date: Thu, 1 Feb 2001 15:15:31 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
Message-ID: <20010201151531.C5706@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A784412.28B455A1@ftel.co.uk> <Pine.LNX.4.10.10101310947170.14252-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101310947170.14252-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jan 31, 2001 at 09:47:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Andre Hedrick wrote:

> On Wed, 31 Jan 2001, Paul Flinders wrote:
> 
> > Talking of the Promise are there any plans to support re-enabling
> > of the 2nd channel for boards which have an on-board FastTrak?
> 
> FastTrak == Ultra - Fake-RAID

But Fake-RAID is CHEAP to get two additional UDMA-5 capable channels :-)
Just jumper for normal ATA/100 mode.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
