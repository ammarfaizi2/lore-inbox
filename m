Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUAXMjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266922AbUAXMjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:39:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:53633 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266917AbUAXMjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:39:13 -0500
Date: Sat, 24 Jan 2004 13:39:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       akpm@zip.com.au
Subject: Re: [patch] Graphire3 support
Message-ID: <20040124123919.GA10247@ucw.cz>
References: <4011BFD7.7030308@mech.kuleuven.ac.be> <20040124082931.GD274@ucw.cz> <401261D6.9010405@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401261D6.9010405@mech.kuleuven.ac.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 01:15:18PM +0100, Panagiotis Issaris wrote:

> >>I got a Wacom Graphire3 for my birthday and unfortunately it didn't 
> >>work. After some playing around, I noticed the 2.6 kernel needs a few 
> >>small modifications to make it work.
> >>
> >>This simple patch adds support for the Wacom Graphire 3.  It applies 
> >>fine to both 2.6.2-rc1-mm2 and 2.6.2-rc1.
> >>   
> >>
> >
> >Thanks, applied to my tree. I suppose you'll be able to find it in
> >2.6.3.
> > 
> >
> Thanks! Unfortunately, there still was a problem regarding the height 
> and width of the tablet.
> This patch fixes it. I've added both a new patch and an incremental one.
> 
> With friendly regards,
> Takis

Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
