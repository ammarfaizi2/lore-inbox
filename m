Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268022AbUGWUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268022AbUGWUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUGWUFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:05:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64452 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267947AbUGWUEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:04:25 -0400
Date: Fri, 23 Jul 2004 22:04:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]: CONFIG_UNSUPPORTED (was: Re: [PATCH] delete devfs)
Message-ID: <20040723200416.GO19329@fs.tum.de>
References: <20040721141524.GA12564@kroah.com> <20040722064952.GC20561@kroah.com> <20040722091335.A17187@home.com> <200407232106.41065.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407232106.41065.rjwysocki@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 09:06:40PM +0200, R. J. Wysocki wrote:

>...
> 2. Proposal
> 
> I propose to introduce a new configuration option CONFIG_UNSUPPORTED, such 
> that if it is not set, the unmaintained/unsupported code will not be compiled 
> into the kernel.  Moreover,
> * IMO the option should not be set by default, which would require a user 
> action to include the unsupported code into the kernel,
> * IMO the option should be documented as to indicate that the code marked with 
> the help of it is not supported by kernel developers and may be removed from 
> the kernel at any time without notification.
>...

Quoting 2.6 MAINTAINERS:

<--  snip  -->

PCMCIA SUBSYSTEM
L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
S:      Unmaintained

<--  snip  -->

> Yours,
> rjw

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

