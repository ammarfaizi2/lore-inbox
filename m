Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTCANy4>; Sat, 1 Mar 2003 08:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbTCANy4>; Sat, 1 Mar 2003 08:54:56 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:32265 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267083AbTCANyz>; Sat, 1 Mar 2003 08:54:55 -0500
Date: Sat, 1 Mar 2003 15:05:13 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds6.pg.gda.pl>
X-X-Sender: blues@piorun.ds.pg.gda.pl
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 DVD DMA problem
In-Reply-To: <200303011253.h21Cr1i4013408@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.50L.0303011503490.17500-100000@piorun.ds.pg.gda.pl>
References: <200303011253.h21Cr1i4013408@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003, Mikael Pettersson wrote:
> >Try this:  http://www.ans.pl/ide/testing/
> >It's backport of IDE subsystem from 2.4 - works really nice.
> Based on 2.4.20 or 2.4.21-pre?
> 
> I've been porting Andre's big 2.2.19 IDE patch up to 2.2.23 since I need
> it for UDMA100 support on Intel ICH and PDC20267, but it doesn't support
> UDMA100 on my 20269. The 2.4.21-pre IDE code supports it, but, as far as
> I know, relies on PCI layer changes which could make it difficult to
> backport to 2.2.

I don't remember
Ask better dzimi@pld.org.pl - he should know that.

-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
