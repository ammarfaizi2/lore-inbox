Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268310AbRG3DyR>; Sun, 29 Jul 2001 23:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268308AbRG3DyH>; Sun, 29 Jul 2001 23:54:07 -0400
Received: from [209.226.93.226] ([209.226.93.226]:46834 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268307AbRG3DyA>; Sun, 29 Jul 2001 23:54:00 -0400
Date: Sun, 29 Jul 2001 23:53:56 -0400
Message-Id: <200107300353.f6U3ruc02345@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v183 available
In-Reply-To: <m3lml7yt4o.fsf@ccs.covici.com>
In-Reply-To: <200107230502.f6N528g05023@vindaloo.ras.ucalgary.ca>
	<m3lml7yt4o.fsf@ccs.covici.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

John Covici writes:
> I have two questions -- please forgive me if they are somewhat dumb.
> 
> First, if I have the 2.4.7 source tree what patch level of devfs do I
> have -- how is that related to the devfs 183 you announced?

Check Documentation/filesystems/devfs/ChangeLog

> Second, I need to change a driver which is now not devfs aware, but
> hangs the kernel if devfs is not present -- where can I get
> documentation for the devfs api?

Build the man pages: the source code has markups so that documentation
can be automatically extracted.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
