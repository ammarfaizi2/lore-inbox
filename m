Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292384AbSBUN7j>; Thu, 21 Feb 2002 08:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292385AbSBUN73>; Thu, 21 Feb 2002 08:59:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8208 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292384AbSBUN7S>;
	Thu, 21 Feb 2002 08:59:18 -0500
Date: Thu, 21 Feb 2002 14:58:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Carlo Scarfoglio <scarfoglio@arpacoop.it>, linux-kernel@vger.kernel.org,
        "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: AIC7XXX 6.2.5 driver
Message-ID: <20020221135846.GA14634@suse.de>
In-Reply-To: <20020221075253.GH2654@suse.de> <E16dtmv-0006z2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16dtmv-0006z2-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21 2002, Alan Cox wrote:
> > You should ask Justin whether he has submitted it for inclusion or not.
> > I offered to port to 2.5 at least, but heard nothing.
> 
> I was sent a patch for it which included some scsi changes, broke support
> for the CMD ide controllers and didn't apply in the aic7xxx area. So I
> threw it in /dev/null

Right, it was an incredibly strange mix. I just disregarded the cmd
stuff, the scsi stuff looked sane. I trust Justin knows the aic7xxx
parts were sane :-)

-- 
Jens Axboe

