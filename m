Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133118AbRDRNG4>; Wed, 18 Apr 2001 09:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133119AbRDRNGr>; Wed, 18 Apr 2001 09:06:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58124 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S133118AbRDRNGi>;
	Wed, 18 Apr 2001 09:06:38 -0400
Date: Wed, 18 Apr 2001 15:06:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        lna@bigfoot.com
Subject: Re: I can eject a mounted CD
Message-ID: <20010418150622.P490@suse.de>
In-Reply-To: <E14pqzO-0004bp-00@the-village.bc.nu> <XFMail.010418150323.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.010418150323.pochini@shiny.it>; from pochini@shiny.it on Wed, Apr 18, 2001 at 03:03:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18 2001, Giuliano Pochini wrote:
> 
> > vmware and one or two other apps I've also seen do this. WHen you unlock the
> > cdrom door as root you can unlock it even if a file system is mounted
> 
> Right, so I'll check what eject(1) does. It might eject the disk even if it
> failed to unmount.

It shouldn't be able to. But check and see what happens.

-- 
Jens Axboe

