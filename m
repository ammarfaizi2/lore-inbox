Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbUCYWtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUCYWrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:47:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63982 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263675AbUCYWrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:47:15 -0500
Date: Thu, 25 Mar 2004 23:47:07 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: 239952@bugs.debian.org, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040325224706.GE16746@fs.tum.de>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Jeff Garzik <jgarzik@pobox.com>, 239952@bugs.debian.org,
	debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de> <20040325082949.GA3376@gondor.apana.org.au> <20040325220803.GZ16746@fs.tum.de> <40635DD9.8090809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40635DD9.8090809@pobox.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 05:31:53PM -0500, Jeff Garzik wrote:
> 
> Well IANAL, but it seems not so cut-n-dried, at least.
> 
> Firmware is a program that executes on another processor, so no linking 
> is taking place at all.  It is analagous to shipping a binary-only 
> program in your initrd, IMO.

My point in this mail was a bit "besides the main firmware discussion":

I was not asking whether it's OK to ship this file in the kernel 
sources, I was asking whether the contents of the file is really under 
the GPL as stated in the header of this file if it contains this binary 
code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

