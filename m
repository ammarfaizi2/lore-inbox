Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTCELDs>; Wed, 5 Mar 2003 06:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTCELDs>; Wed, 5 Mar 2003 06:03:48 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:59919 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S265396AbTCELDC>; Wed, 5 Mar 2003 06:03:02 -0500
Date: Wed, 5 Mar 2003 12:13:29 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds6.pg.gda.pl>
X-X-Sender: blues@piorun.ds.pg.gda.pl
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 DVD DMA problem
In-Reply-To: <Pine.LNX.3.96.1030304154132.14509A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.51L.0303051213120.8615@piorun.ds.pg.gda.pl>
References: <Pine.LNX.3.96.1030304154132.14509A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Bill Davidsen wrote:
> > > In 2.2.20 enabling DMA on a DVD drive with hdparm stopped the
> > > lurching of DVD movies, when doing the same in a 2.4.20 environment
> > > (with all the DMA options compiled into the kernel, see below), the
> > > lurching stays. Thanks for any ideas...
> > Try this:  http://www.ans.pl/ide/testing/
> > It's backport of IDE subsystem from 2.4 - works really nice.
> Did I miss something? Micah said DMA fixed the problem in 2.2 but not in
> 2.4, why would he want a backport of the code which has the problem to
> the kernel which works?

sorry, my fault :)

-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
