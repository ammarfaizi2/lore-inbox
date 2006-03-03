Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWCCP6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWCCP6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWCCP6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:58:54 -0500
Received: from trinity.fluff.org ([212.13.204.133]:23008 "EHLO
	trinity.fluff.org") by vger.kernel.org with ESMTP id S1751484AbWCCP6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:58:53 -0500
Date: Fri, 3 Mar 2006 15:57:59 +0000
From: Ben Dooks <ben-linux-arm@fluff.org>
To: Koen Martens <linuxarm@metro.cx>
Cc: Pavel Machek <pavel@ucw.cz>, ben@simtec.co.uk,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/14] s3c2412/s3c2413 support
Message-ID: <20060303155759.GA16278@trinity.fluff.org>
References: <44082001.9090308@metro.cx> <20060303151023.GB2580@ucw.cz> <44085F31.6040705@metro.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44085F31.6040705@metro.cx>
User-Agent: Mutt/1.3.28i
X-Disclaimer: These are my views alone.
X-URL: http://www.fluff.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:22:25PM +0100, Koen Martens wrote:
> Pavel Machek wrote:
> 
> >On Fri 03-03-06 11:52:49, Koen Martens wrote:
> > 
> >
> >>This patchset adds various defines and bits for the 
> >>s3c2412 and s3c2413
> >>processors, as well as adding detection of this cpu to 
> >>platform setup and
> >>uncompress boot stage.
> >>The changes should not disturb current s3c24xx 
> >>implementations. The
> >>patchset is preliminary, in that the final datasheet is 
> >>not yet available. We
> >>did some testing of these new registers and bits outside 
> >>of the linux
> >>kernel.
> >>   
> >>
> >
> >Ahha, it is actually arm derivative. Still it would be nice to have
> >better name.

Limiting it to linux-arm-kernel may have been a better
idea, since it is to do with items under arch/arm, the
intended audience should all be subscribed to the list.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

