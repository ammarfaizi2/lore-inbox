Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWHREzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWHREzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 00:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWHREzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 00:55:10 -0400
Received: from 1wt.eu ([62.212.114.60]:23312 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1160999AbWHREzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 00:55:09 -0400
Date: Fri, 18 Aug 2006 06:47:45 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas Backlund <tmb@mandriva.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060818044745.GN8776@1wt.eu>
References: <20060817075705.79729.qmail@web52908.mail.yahoo.com> <ec1c5j$5mu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec1c5j$5mu$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 12:16:56PM +0300, Thomas Backlund wrote:
> Chris Rankin skrev:
> >>But maybe it's worth doing a user survey to find out what the users of
> >>2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
> >>people who use enterprise distro kernels don't count for this since
> >>they'll not go to a newer released 2.4 anyway)
> >
> >I have only one machine that is still running a v2.4 kernel (from 
> >ftp.kernel.org), and that is an
> >old P120 that I occasionally use as a wireless acess point.
> >
> >The compiler on this P120 is indeed gcc-3.4. However, building any kernel 
> >on that machine is now
> >so excruciatingly painful that I am considering using a newer, beefier 
> >machine as a build machine
> >instead. That machine is running FC5, and so uses gcc-4.1. So from my 
> >perspective, being able to
> >build a 2.4 kernel using gcc-4.x would be a benefit.
> >
> >
> 
> Why not simply set up chroots to build in ??

"simply" :-)
setting up a reliable build chroot is more difficult than just rebuilding
another gcc !

> Thomas

Regards,
willy

