Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275305AbTHMTRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275308AbTHMTRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:17:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7912 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275305AbTHMTRT (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:17:19 -0400
Date: Wed, 13 Aug 2003 21:17:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Tomas Szepe <szepe@pinerecords.com>,
       John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030813191709.GI569@fs.tum.de>
References: <20030731091525.GI12849@louise.pinerecords.com> <Pine.LNX.3.96.1030813104305.11041B-100000@gatekeeper.tmr.com> <20030813153144.GA10579@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813153144.GA10579@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 11:31:45AM -0400, Jeff Garzik wrote:
> On Wed, Aug 13, 2003 at 10:50:12AM -0400, Bill Davidsen wrote:
>...
> > If you get a bunch of compiler errors without a clear indication that the
> > driver is known to have problems, it is more likely to produce a "Linux is
> > crap" reaction. With the problems Windows is showing this week, I'd like
> > to show Linux as the reliable alternative, not whatever MS is saying about
> > hacker code this week.
> 
> The people who want Linux to be reliable won't be compiling their own
> kernels, typically.  Because, the people that _do_ compile their own
> kernels have sense enough to disable broken drivers :)  That's what Red
> Hat, SuSE, and others do today.

It occurs quite often that you need e.g. the latest -pre or -ac to
support some of your hardware.

These are situations when an average systems administrator has to 
compile his on kernel.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

