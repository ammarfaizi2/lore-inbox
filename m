Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275094AbSITGQt>; Fri, 20 Sep 2002 02:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275117AbSITGQt>; Fri, 20 Sep 2002 02:16:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63707 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S275094AbSITGQr>;
	Fri, 20 Sep 2002 02:16:47 -0400
Date: Fri, 20 Sep 2002 08:21:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Dave Olien <dmo@osdl.org>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020920062141.GE3990@suse.de>
References: <E17odbY-000BHv-00@f1.mail.ru> <E17s6nH-0000xq-00@starship> <20020919150958.A27837@acpi.pdx.osdl.net> <E17s9gL-00010c-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17s9gL-00010c-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20 2002, Daniel Phillips wrote:
> On Friday 20 September 2002 00:09, Dave Olien wrote:
> > Daniel,
> > 
> > My mailer here has been misbehaving.  I didn't think THIS mail
> > had actually made it out.  So, you may be seeing another version
> > of this mail sometime.  Just ignore it.
> > 
> > I think some coding style repairs would be great!  But I'd like to
> > hold off on that until we've finished all the functional changes.
> > That way, anyone doing a code review can easily see only the
> > changes to make the driver function.
> > 
> > Once functional changes are mostly complete, then cleaning up
> > some coding style issues would be a good thing.
> 
> Yep.  And this is not a halloween deadline kind of thing, or more
> accurately, you just did the halloween part of it.  The rest of the
> job is to try to make it nice.  It would be great to find out if the
> hardware is really as slow as it seems, or if it's the driver.

Not at all a Halloween thing, this is just a driver update.

> > Regarding being a mainteiner, lets get the code changes done
> > first ;-)
> 
> It's working!  I see this in very simple terms ;-)

Good that it's working, but I would have to agree with Dave, there's
still lots of work to be done. pci dma mapping is not complete, for one.

-- 
Jens Axboe

