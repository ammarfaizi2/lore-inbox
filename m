Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbTDPPfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTDPPfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:35:53 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:48100 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S264583AbTDPPfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:35:51 -0400
Date: Wed, 16 Apr 2003 11:47:15 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Brien <admin@brien.com>
cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
In-Reply-To: <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>
Message-ID: <Pine.LNX.4.53.0304161145060.11615@filesrv1.baby-dragons.com>
References: <200304161511.h3GFBoe7000614@81-2-122-30.bradfords.org.uk>
 <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Brian ,  Try this then run memtest86 against each mem stick
	seperately .  It sounds as if you tried both at the same time ?
		Hth ,  JimL

On Wed, 16 Apr 2003, Brien wrote:
> Hi again,
> (Thanks for replying, John.)
> I ran Memtest86, and there're 290 errors that showed up from test 7. But the
> thing that I don't understand is, if I use either of the RAM modules alone,
> Linux loads and runs perfectly for as long as I've tried; Could it possibly
> be a problem with something besides the RAM (e.g. motherboard, CPU)? And I
> still don't know if my RAM setup is even supported by Linux -- I'm guessing
> that it is though (?).

> ----- Original Message -----
> From: "John Bradford" <john@grabjohn.com>
> To: "Brien" <admin@brien.com>
> Sent: Wednesday, April 16, 2003 11:11 AM
> Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
> > > I have a Gigabyte SINXP1394 motherboard, and 2 Kingston 512 MB DDR 400
> (CL
> > > 2.5) RAM modules installed. Whenever I try to install any Linux
> > > distribution, I always get a black screen after the kernel loads
> > Can you run Memtest86 on it for an hour or two, and confirm that there
> > is nothing wrong with the memory?  Sometimes really obscure faults
> > happen to get triggered with Linux, even if the machine appears to
> > work with other operating systems.
> > (By the way, good choice getting a Gigabyte board, I always use them,
> > and never have problems with them).
> > John.
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
