Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTEITCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTEITCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:02:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263429AbTEITCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:02:06 -0400
Subject: Re: ALSA busted in 2.5.69
From: Andy Pfiffer <andyp@osdl.org>
To: walt <wa1ter@hotmail.com>
Cc: Torrey Hoffman <thoffman@arnor.net>, Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBBF00D.8040108@hotmail.com>
References: <fa.j6n4o02.sl813a@ifi.uio.no> <fa.juutvqv.1inovpj@ifi.uio.no>
	 <3EBBF00D.8040108@hotmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052507530.15922.37.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 May 2003 12:12:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 11:14, walt wrote:
> Torrey Hoffman wrote:
> > On Fri, 2003-05-09 at 01:09, Giuliano Pochini wrote:
> > 
> >>On 08-May-2003 Torrey Hoffman wrote:
> >>
> >>>ALSA isn't working for me in 2.5.69.  It appears to be because
> >>>/proc/asound/dev is missing the control devices.
> > ...
> >>If you are not using devfs, you need to create the devices. There is a
> >>script in the ALSA-driver package to do that. Otherwise I can't help
> >>you because I never tried devfs and linux 2.5.x.
> > 
> > No.  /dev/snd is a symbolic link to /proc/asound/dev,
> > and that symbolic link was created by the script you mention.
> > (I am not using devfs.)

I'm not using devfs, and I've had no luck getting ALSA to work on my
i810-audio system.  OSS works fine.

Is there a step-by-step writeup available for morons like me that
haven't gotten ALSA working?

Thanks,
Andy


