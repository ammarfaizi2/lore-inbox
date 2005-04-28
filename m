Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVD1HDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVD1HDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVD1HCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:02:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:17548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261809AbVD1HAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:00:52 -0400
Date: Wed, 27 Apr 2005 23:59:33 -0700
From: Greg KH <gregkh@suse.de>
To: Gregor Jasny <gjasny@web.de>
Cc: LKML LIST <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
       stable@kernel.org
Subject: Re: [stable] Re: [00/07] -stable review
Message-ID: <20050428065933.GB12086@kroah.com>
References: <20050427171446.GA3195@kroah.com> <200504280849.53777.gjasny@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504280849.53777.gjasny@web.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 08:49:53AM +0200, Gregor Jasny wrote:
> Hi Greg, hi Takashi,
> 
> I would suggest these two patches for inclusion into the stable tree. They 
> both fix a keyboard lockup when unplugging USB audio hardware.
> 
> With the first one applied I can plug / unplug my webcam without losing my 
> keyboard. I couldn't test the second one, but both patches are in ALSA CVS.
> 
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usbaudio.c?r1=1.119&r2=1.120
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/usb/usx2y/usbusx2y.c?r1=1.9&r2=1.10

Are they in the mainline kernel tree already?

Care to send them individually to the stable@ address, along with full
changelog information and signed-off-by lines?

thanks,

greg k-h
