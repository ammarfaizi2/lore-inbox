Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269530AbTCDUhA>; Tue, 4 Mar 2003 15:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269531AbTCDUhA>; Tue, 4 Mar 2003 15:37:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48657 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S269530AbTCDUg7> convert rfc822-to-8bit; Tue, 4 Mar 2003 15:36:59 -0500
Date: Tue, 4 Mar 2003 15:43:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 DVD DMA problem
In-Reply-To: <Pine.LNX.4.50L.0303011032280.17500-100000@piorun.ds.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1030304154132.14509A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003, [ISO-8859-2] Pawe³ Go³aszewski wrote:

> On Fri, 28 Feb 2003, Micah Anderson wrote:
> > In 2.2.20 enabling DMA on a DVD drive with hdparm stopped the lurching
> > of DVD movies, when doing the same in a 2.4.20 environment (with all the
> > DMA options compiled into the kernel, see below), the lurching stays.
> > Thanks for any ideas...
> 
> Try this:  http://www.ans.pl/ide/testing/
> It's backport of IDE subsystem from 2.4 - works really nice.

Did I miss something? Micah said DMA fixed the problem in 2.2 but not in
2.4, why would he want a backport of the code which has the problem to the
kernel which works?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

