Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSA3BSe>; Tue, 29 Jan 2002 20:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSA3BSY>; Tue, 29 Jan 2002 20:18:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35525 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S287840AbSA3BSI>;
	Tue, 29 Jan 2002 20:18:08 -0500
Date: Tue, 29 Jan 2002 20:18:06 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Stuart Young <sgy@amc.com.au>
Cc: linux-kernel@vger.kernel.org,
        Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        John Weber <weber@nyc.rr.com>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129201806.B12201@havoc.gtf.org>
In-Reply-To: <3C5600A6.3080605@nyc.rr.com> <87n0yxqa6e.fsf@tigram.bogus.local> <5.1.0.14.0.20020130113958.00a04390@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.0.20020130113958.00a04390@mail.amc.localnet>; from sgy@amc.com.au on Wed, Jan 30, 2002 at 12:00:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 12:00:11PM +1100, Stuart Young wrote:
> Perhaps it's time we set up a specific lkml-patch mailing list, and leave 

I like the suggestion (most recently, of Daniel?  pardon if I
miscredit) of having patches-2.[45]@vger.kernel.org type addresses,
which would archive patches, and have a high noise-to-signal ratio.
Maybe even filter out all non-patches.

The big issue I cannot decide upon is whether standard e-mails should be
	To: torvalds@
	CC: patches-2.4@
or just
	To: patches-2.4@

(I'm guessing Linus would prefer the first, but who knows)

Also, something noone has mentioned is out-of-band patches.  Security fixes and other
patches which for various reasons go straight to Linus.

	Jeff


