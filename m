Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRCIO1m>; Fri, 9 Mar 2001 09:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRCIO1c>; Fri, 9 Mar 2001 09:27:32 -0500
Received: from letterman.noris.net ([62.128.1.26]:13319 "EHLO mail1.noris.net")
	by vger.kernel.org with ESMTP id <S130516AbRCIO10>;
	Fri, 9 Mar 2001 09:27:26 -0500
From: "Matthias Urlichs" <smurf@noris.de>
Date: Fri, 9 Mar 2001 15:26:59 +0100
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010309152659.E8922@noris.de>
In-Reply-To: <1epyyz1.etswlv1kmicnqM%smurf@noris.de> <20010309075908.Z8922@noris.de> <20010309125148.E8322@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010309125148.E8322@suse.de>; from axboe@suse.de on Fri, Mar 09, 2001 at 12:51:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jens Axboe:
> > But most disks these days support IDE-SCSI, and SCSI does have ordered
> > tags, so...
> 
> Any proof to back this up? To my knowledge, only some WDC ATA disks
> can be ATAPI driven.
> 
Ummm, no, but that was my impression. If that's wrong, I apologize and
will state the opposite, next time.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
-- 
You see things; and you say 'Why?'
But I dream things that never were; and I say 'Why not?'
               --George Bernard Shaw [Back to Methuselah]
