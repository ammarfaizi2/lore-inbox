Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTLBQCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLBQCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:02:19 -0500
Received: from strauss.physik.TU-Cottbus.De ([141.43.75.28]:38600 "EHLO
	strauss.physik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S262291AbTLBQCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:02:17 -0500
Date: Tue, 2 Dec 2003 17:01:36 +0100
From: Ionut Georgescu <george@physik.tu-cottbus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202160136.GB10915@physik.tu-cottbus.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <20031202131311.GA10915@physik.tu-cottbus.de> <3FCC95BB.60205@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCC95BB.60205@wmich.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 08:38:03AM -0500, Ed Sweetman wrote:
> 
> The point was, the patch is perfectly and easily usable the way it is. 
> There stands to be no reason to make it part of the vanilla kernel other 
> than a very slight convenience factor for a small minority of users. 
> Tosatti thinks that that versus changes to this stable kernel that touch 
> common code are unacceptable.  Despite the maturity of the project, it 
> just doesn't make sense to include it in the vanilla kernel, it would be 
> a disservice to the rest of the users of 2.4.x kernels that do so for 
> stability, not only in the not crashing sense, but also in the code-base 
>  sense. And the number of users who don't use xfs so greatly outnumber 
> the users that do that it's a mute point for Tosatti.
> Just suck it up, plug on with the complex command of cat xfs.patch | 
> patch -p1 or move up to 2.6.  Anyone using xfs can obviously do either 
> already and everyone not can continue not being affected by new code if 
> they dont want to.
> 

I can understand that, but I don't take 2.6 for an answer.  2.4 is not
yet dead and it won't be for a long time, just as 2.2 has gotten to
2.2.25, although 2.4.0 was out when, 3 years ago ?

Ionut


-- 
***************
* Ionut Georgescu
* http://www.physik.tu-cottbus.de/~george/
* Registered Linux User #244479
*
* "In Windows you can do everything Microsoft wants you to do; in Unix you
*                can do anything the computer is able to do."

