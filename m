Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVCUHcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVCUHcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 02:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVCUHcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 02:32:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:3560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbVCUHcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 02:32:45 -0500
Date: Sun, 20 Mar 2005 23:32:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: viking <viking@flying-brick.caverock.net.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse hiccups (was RFD: Kernel release numbering)
Message-Id: <20050320233227.2c7b8013.akpm@osdl.org>
In-Reply-To: <20050321072601.GA31826@flying-brick.caverock.net.nz>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz>
	<20050320164129.44d3a065.akpm@osdl.org>
	<20050321072601.GA31826@flying-brick.caverock.net.nz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viking <viking@flying-brick.caverock.net.nz> wrote:
>
> On Sun, Mar 20, 2005 at 04:41:29PM -0800, Andrew Morton wrote:
> > viking <viking@flying-brick.caverock.net.nz> wrote:
> > >
> > > I did note something strange. I'm running 2.6.11.2 at this moment, when I
> > >  tried 2.6.11.3, my USB Microsoft Wireless Optical Mouse stopped moving
> > >  from left to right, and would only move up and down if I physically moved
> > >  the mouse from left to right. I didn't see anything in the patches that
> > >  touched anything in the event handling, so frankly I'm puzzled.
> > >  Any clues as to where I need to look? I've seen this problem before, but
> > >  don't know what causes it, nor how I fixed it at the time.
> > >  Also, how do I get that patch that enables the tiltwheel (left-right
> > >  events)?
> > 
> > Could you please test 2.6.12-rc1?
> 
> Got it compiled this evening. How many days do you want me to run it for? A
> week?

Well it should take about seven seconds to work out if the mouse movement
is still broken?

> Can I test out the suspend-to-disk on this release too?

Please do.

