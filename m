Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131600AbRCSVxI>; Mon, 19 Mar 2001 16:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRCSVw7>; Mon, 19 Mar 2001 16:52:59 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:58276 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S131642AbRCSVwi>; Mon, 19 Mar 2001 16:52:38 -0500
Message-ID: <3AB67F7C.34E093F8@bigfoot.com>
Date: Mon, 19 Mar 2001 13:51:56 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <Pine.LNX.4.10.10103191448010.5246-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> > > > I have an IBM DTLA 307030 (ATA 100 / UDMA 5) on an 815e board (Asus CUSL2), which has a PIIX4 controller.
> > > > ...
> > > > My problem is that (according to hdparm -t), I never get a better transfer rate than approximately 15.8 Mb/sec....
> > >
> > > 15MB/s for hdparm is about right.
> 
> it's definitely not right: this disk sustains around 35 MB/s.

The 815e does not use a PIIX4 chipset.  My references were to PIIX4
chipsets.

> nonsequitur: the controller and disk are both quite capable of
> sustaining 20-35 MB/s (depending on zone.)  here's hdparm output
> for a disk of the same rpm and density as the DTLA's:
> 
>  Timing buffer-cache reads:   128 MB in  1.07 seconds =119.63 MB/sec
>  Timing buffered disk reads:  64 MB in  2.02 seconds = 31.68 MB/sec
> 
> (maxtor dm+45, hpt366 controller)
> regards, mark hahn.

Again, this is not a PIIX4 chipset.

rgds,
tim.
--
