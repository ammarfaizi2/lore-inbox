Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbTCAJYm>; Sat, 1 Mar 2003 04:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268538AbTCAJYm>; Sat, 1 Mar 2003 04:24:42 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:57606 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268537AbTCAJYm>; Sat, 1 Mar 2003 04:24:42 -0500
Date: Sat, 1 Mar 2003 10:34:59 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 DVD DMA problem
In-Reply-To: <20030301055245.GE24044@mars.riseup.net>
Message-ID: <Pine.LNX.4.50L.0303011032280.17500-100000@piorun.ds.pg.gda.pl>
References: <20030301055245.GE24044@mars.riseup.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003, Micah Anderson wrote:
> In 2.2.20 enabling DMA on a DVD drive with hdparm stopped the lurching
> of DVD movies, when doing the same in a 2.4.20 environment (with all the
> DMA options compiled into the kernel, see below), the lurching stays.
> Thanks for any ideas...

Try this:  http://www.ans.pl/ide/testing/
It's backport of IDE subsystem from 2.4 - works really nice.

-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
