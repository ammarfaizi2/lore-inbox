Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287447AbSADSmQ>; Fri, 4 Jan 2002 13:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSADSl5>; Fri, 4 Jan 2002 13:41:57 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:34775 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287447AbSADSlw>; Fri, 4 Jan 2002 13:41:52 -0500
Date: Fri, 4 Jan 2002 11:41:47 -0700
Message-Id: <200201041841.g04IflL23687@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Dave Jones <davej@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <Pine.LNX.4.33.0201041940150.20620-100000@Appserv.suse.de>
In-Reply-To: <200201041831.g04IVAD23320@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0201041940150.20620-100000@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
> On Fri, 4 Jan 2002, Richard Gooch wrote:
> 
> > Please test this change on a libc5 system before unleashing a
> > potential horror. All the world *is not* glibc!
> 
> Am I alone in finding the idea of running 2.5/2.6 on a libc5
> system a little strange ?

Not if you want a lightweight C library. Such as when running off a CF
card.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
