Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271550AbRHZUVb>; Sun, 26 Aug 2001 16:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRHZUVW>; Sun, 26 Aug 2001 16:21:22 -0400
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:3337 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP
	id <S271515AbRHZUVR>; Sun, 26 Aug 2001 16:21:17 -0400
Date: Sun, 26 Aug 2001 21:21:32 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with module esssolo1.o
Message-ID: <20010826212132.A17491@compsoc.man.ac.uk>
In-Reply-To: <01082622002001.00938@sharkie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01082622002001.00938@sharkie>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 10:00:20PM +0200, Marcel Loesberg wrote:

> 
> When I try to compile and install the esssolo1.o module I get the following
> error after typing "make modules_install".

use the ac series of kernels, or enable joystick + gameport support.

regards
john

p.s. my esssolo1 seems really broken, often it switches into high-pitched screams,
or the DMA times out (permanently). The driver seems to try forever, making the module unloadable

-- 
"That's just kitten-eating wrong."
	- Richard Henderson
