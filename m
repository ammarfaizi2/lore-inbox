Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264016AbRFFSlQ>; Wed, 6 Jun 2001 14:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264014AbRFFSlE>; Wed, 6 Jun 2001 14:41:04 -0400
Received: from coruscant.franken.de ([193.174.159.226]:32528 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S264022AbRFFSk5>; Wed, 6 Jun 2001 14:40:57 -0400
Date: Wed, 6 Jun 2001 15:22:45 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Tomas Telensky <ttel5535@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010606152245.F14579@corellia.laforge.distro.conectiva>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <20010606200933.B16802@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010606200933.B16802@artax.karlin.mff.cuni.cz>; from ttel5535@artax.karlin.mff.cuni.cz on Wed, Jun 06, 2001 at 08:09:33PM +0200
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Setting Orange, the 9th day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 08:09:33PM +0200, Tomas Telensky wrote:
> > Hi!
> > 
> > Is there any way to read out the compile-time HZ value of the kernel?
> 
> Why simply #include <asm/param.h>?

because the include file doesn't say anything about the HZ value of 
the currently running kernel, but only about some kernel source somewhere
on your harddrive?


> 	Tomas

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
