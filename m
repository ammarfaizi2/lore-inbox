Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRHYVz0>; Sat, 25 Aug 2001 17:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbRHYVzQ>; Sat, 25 Aug 2001 17:55:16 -0400
Received: from mean.netppl.fi ([195.242.208.16]:13576 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S268598AbRHYVzC>;
	Sat, 25 Aug 2001 17:55:02 -0400
Date: Sun, 26 Aug 2001 00:55:15 +0300
From: =?iso-8859-1?Q?Pekka_Pietik=E4inen?= <pp@netppl.fi>
To: "Marti, Felix" <fmarti@desanasystems.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: userspace implementation of tcp/ip
Message-ID: <20010826005515.A22289@netppl.fi>
In-Reply-To: <1DF71FB881F4D311A6B700C04FA06A1AC437D0@orca.desanasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1DF71FB881F4D311A6B700C04FA06A1AC437D0@orca.desanasystems.com>; from fmarti@desanasystems.com on Sat, Aug 25, 2001 at 11:47:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 11:47:20AM -0700, Marti, Felix wrote:
> Hi there,
> 
> I remember that somebody ported the linux tcp/ip stack to userspace a long
> time ago. Does anybody have a link to that project?
Hi

I'm not sure if it's the thing you're looking for, but 
http://www.cl.cam.ac.uk/Research/SRG/netos/arsenic/
did that. I never got their code running, though,
their modified acenic firmware didn't run at all, and according
to the docs it required a rev5 board (rev4 and 6 are what people usually
have). Still, it might be possible to use their userland tcp/ip
library in other projects with some hackery.

-- 
Pekka Pietikainen
