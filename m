Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbRBNECO>; Tue, 13 Feb 2001 23:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBNECE>; Tue, 13 Feb 2001 23:02:04 -0500
Received: from nvgate.nvidia.com ([140.174.105.2]:12920 "EHLO
	thelma.NVidia.COM") by vger.kernel.org with ESMTP
	id <S129150AbRBNEBx>; Tue, 13 Feb 2001 23:01:53 -0500
Date: Tue, 13 Feb 2001 20:02:20 -0800 (PST)
From: Mark Vojkovich <mvojkovich@nvidia.com>
To: xpert@xfree86.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [Xpert]Video drivers and the kernel
In-Reply-To: <3A89F1A5.7050603@bellsouth.net>
Message-ID: <Pine.LNX.4.21.0102131937590.1564-100000@mvojkovich1.nvidia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Louis Garcia wrote:

> I was wondering why video drivers are not part of the kernel like every 
> other piece of hardware. I would think if video drivers were part of the 
> kernel and had a nice API for X or any other windowing system, would not 
> only improve performance but would allow competing windowing systems 
> without having to develop drivers for each. Has anyone thought or 
> rejected this idea.


  You should drop this subject as it will only result in flame
wars.  They have in the past and the result is always the same...

1)  XFree86 is about the X window system.  We don't give a damn about
    competing window systems. 

2)  There isn't a single API that can encompass all hardware.

3)  Kernel drivers are OS specific things and XFree86 runs on 
    too many platforms so we won't be able to abandon
    user-space drivers.  At least not any time soon.

   That said, there are fbdev drivers for XFree86 and there are
some hardware-specific solutions like NVIDIA's binary drivers.
If you want to do something else, that's your perrogative. But
don't waste your time trying to get everybody to agree with
you.  I won't happen.

   Sorry to be a bit abrupt, but there have been a few other
discussions of this nature in the past and it's best that it
doesn't go much further.  At least not on XFree86 lists. 

				Mark.
   

