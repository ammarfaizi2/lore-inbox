Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVCKXzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVCKXzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCKXzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:55:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:61155 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261820AbVCKXwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:52:19 -0500
Subject: Re: [PATCH] ppc32: move powermac backlight stuff to a workqueue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0503111809080.10827@pentafluge.infradead.org>
References: <1110519593.5751.9.camel@gaston>
	 <Pine.LNX.4.56.0503111809080.10827@pentafluge.infradead.org>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 10:49:43 +1100
Message-Id: <1110584983.5809.118.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 18:10 +0000, James Simmons wrote:
> > I hope I'll replace this by the new backlight framework in a future
> > kernel version, but for now, this will fix the immediate issues with
> > radeon.
> 
> Is it possible to move it over to the new backlight code that is in 
> drivers/video/backlight ?

Ugh... I wrote that I itend to move it over to it and you ask if it's
possible to move it over to it ? :)

I will do when I have time for it, I have more urgent stuffs on my list
at the moment.

Ben.


