Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266934AbRGHReY>; Sun, 8 Jul 2001 13:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbRGHReJ>; Sun, 8 Jul 2001 13:34:09 -0400
Received: from [194.213.32.142] ([194.213.32.142]:19972 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266934AbRGHRdc>;
	Sun, 8 Jul 2001 13:33:32 -0400
Date: Sat, 30 Jun 2001 16:22:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: Vincent Sweeney <v.sweeney@dexterus.com>
Cc: linux-kernel@vger.kernel.org, kdc@nh.ultranet.com,
        linux-scalability@citi.umich.edu
Subject: Re: PATCH (2.4.5): /dev/poll support
Message-ID: <20010630162208.A88@toy.ucw.cz>
In-Reply-To: <009b01c0ff3f7e24b0070c0a0a@DEVPC01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <009b01c0ff3f7e24b0070c0a0a@DEVPC01>; from v.sweeney@dexterus.com on Wed, Jun 27, 2001 at 08:28:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> I think pgp-signing just barfed my last email (typical) so I'm retyping /
> resending this:
> 
> Hi,
>     this patch adds Solaris 7/8 like /dev/poll support to the kernel.
> 
> I can claim no real credit for this as basically this is a fixed version of
> a patch available from http://www.citi.umich.edu/projects/linux-scalability/
> to compile correctly with 2.4.5 that only seemed to work with the 2.3.x
> devel branch. The reason for this is so I can compile & test an application
> on my home linux pc when I'm not around my nice work Solaris boxes :)
> 
> Please note, I have not got the knowledge of kernel development to know if
> this patch is broken or badly written. It may be bugged and/or worse than
> the standard poll() call but my application works so I'll leave profiling
> etc to people more knowledgable than me.

where is the patch?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

