Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263163AbTCWTdT>; Sun, 23 Mar 2003 14:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263161AbTCWTdS>; Sun, 23 Mar 2003 14:33:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60169 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263163AbTCWTdR>; Sun, 23 Mar 2003 14:33:17 -0500
Date: Sun, 23 Mar 2003 20:44:23 +0100
From: Martin Mares <mj@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

> Several
> -	We aren't about to release an official kernel right now afaik,
> 	there are bugs left to sort out first

But these patches can be easily postponed to the next release and now
we can release just the bug fix as you did in the 2.2 series.

> -	Anyone can apply the patch themselves
> -	Anyone can go and get a vendor kernel
> -	Anyone can go and release their own 2.4.20.1 or 2.4.20-sec or
> 	whatever if they feel strongly about it

No, I asked you for reasons against, you gave me (except for the first
point) just reasons why it won't hurt too much.

Do you really think that "People should either use vendor kernels or
read LKML and be able to gather the fixes from there themselves" is a
good strategy?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Next lecture on time travel will be held on previous Monday.
