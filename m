Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276737AbRJQQIG>; Wed, 17 Oct 2001 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276813AbRJQQH4>; Wed, 17 Oct 2001 12:07:56 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:45369 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S276737AbRJQQHq>; Wed, 17 Oct 2001 12:07:46 -0400
From: "Steven A. DuChene" <sduchene@mindspring.com>
Date: Wed, 17 Oct 2001 12:08:12 -0400
To: Thomas Hood <jdthood@mail.com>
Cc: "Steven A. DuChene" <sduchene@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
Message-ID: <20011017120812.E2015@lapsony.mydomain.here>
In-Reply-To: <1003288485.14282.100.camel@thanatos> <20011017041014.B2015@lapsony.mydomain.here> <1003325742.12542.164.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <1003325742.12542.164.camel@thanatos>; from jdthood@mail.com on Wed, Oct 17, 2001 at 09:35:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 09:35:34AM -0400, Thomas Hood wrote:
> On Wed, 2001-10-17 at 04:10, Steven A. DuChene wrote:
> > OK, I tried this with the Intel STL2 motherboard I also have and I got
> > a similar error when trying to load the correct i2c bus module when the
> > PnPBIOS stuff is compiled into the kernel.
> 
> Understood.
> 
> I'd just like to reiterate that my patch isn't the cause
> of your problem.  It's just that my patch doesn't address
> your problem.  IIUC.

Yes, I understood that from the start of all of this but you seemed to be
be the only person messing with the PnPBIOS code so I thought you might be
interested in this annomoly. I appreciate the info/help you have provided
so far.

> 
> I provided a "workaround patch" before.  Can you continue
> to use that for the time being?
> 

Yes, but according to these latest results that work around of skipping a
particular ioport would have to be different for each motherboard with this
problem. There must be a better way to do this.

> I'd like to make a promise that I'll submit a new patch
> soon that will address your problem; however I don't yet know
> exactly how to go about addressing it.
> 

Perhaps someone else can provide us a hint or two as to where to start. :-)
-- 
Steven A. DuChene	sad@ale.org
			linux-clusters@mindspring.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
