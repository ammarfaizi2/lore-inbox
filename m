Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272560AbTHNQzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272567AbTHNQzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:55:18 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:31759 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S272560AbTHNQzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:55:14 -0400
Date: Thu, 14 Aug 2003 17:55:12 +0100
From: John Levon <levon@movementarian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030814165512.GA36329@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org> <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060879622.5983.7.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19nLNY-0000vv-GT*SH82Rp572o6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 05:47:03PM +0100, Alan Cox wrote:

> I see no problem with it either going or becoming an arch specific
> module someone can go write if they care about it and insmod if they
> actually use.

And then I'm stuck with no sensible way to figure out the kernel pointer
size again... all user-space suggestions having the problems listed
in this thread :

http://marc.theaimsgroup.com/?t=104205635900001&r=1&w=2

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
