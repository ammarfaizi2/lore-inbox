Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272788AbTHENsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272789AbTHENsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:48:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56802 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272788AbTHENsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:48:35 -0400
Date: Tue, 5 Aug 2003 15:48:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: heine@instmath.rwth-aachen.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
Message-ID: <20030805134823.GD16091@fs.tum.de>
References: <200308051242.h75CgSj6028203@harpo.it.uu.se> <20030805130324.GC16091@fs.tum.de> <16175.45710.993756.301205@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16175.45710.993756.301205@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 03:35:10PM +0200, Mikael Pettersson wrote:
> 
> ftape-4.04? That's been a non-integrated external package for ages and ages.
> I doubt there's been any updates in it for 2.5/2.6 kernels.
>...

Is there a good reason why it wasn't / isn't integrated?

> Given how few still use these antiques (my "fast" Conner/Seagate drive gives
> 150KBps backup speed, wow!) I think simply maintaining status quo is the most
> reasonable use of peoples' time.

The problem is that 2.6 doesn't maintain the status quo - it's no longer 
possible to use ftape on a SMP workstation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

