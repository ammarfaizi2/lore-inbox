Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSIWV5t>; Mon, 23 Sep 2002 17:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSIWV5t>; Mon, 23 Sep 2002 17:57:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50954 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261490AbSIWV5s>;
	Mon, 23 Sep 2002 17:57:48 -0400
Date: Mon, 23 Sep 2002 15:03:02 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
Message-ID: <20020923150302.A16033@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net> <E17tZyv-0003be-00@starship> <20020923144144.A15852@acpi.pdx.osdl.net> <E17tb9H-0003d7-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17tb9H-0003d7-00@starship>; from phillips@arcor.de on Mon, Sep 23, 2002 at 11:53:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


By the way, I don't know how extensive your code reviewing 
of my changes has been.

This morning I sent you the complete driver patch from 2.5.38
to the latest version of the driver.  That contains all of
the changes I sent you last week, plus new ones.

Would it be better for me to send you incremental patches
in the future?  I could instead generate a patch relative to the
previous version of the driver I sent you.

Let me know what works better for you, based on where you are in code
reviewing.

Thanks!

On Mon, Sep 23, 2002 at 11:53:47PM +0200, Daniel Phillips wrote:
> On Monday 23 September 2002 23:41, Dave Olien wrote:
> > On Mon, Sep 23, 2002 at 10:39:00PM +0200, Daniel Phillips wrote:
> > > Minor whitespace suggestion: don't worry too much about breaking up
> > > lines to fit in 80 columns.  It's nice where it works, but where it
> > > just makes more lines, don't bother.  We are going to go do spelling
> > > patches to shorten a lot of those names anyway.
> > 
> > thanks.
> > I'd been wondering whether there was a guidline for this.
> > I'll relax my 80 column constraints.
> 
> It's a lot more important for core kernel, and ever there, a few lines
> tend to break loose here and there.
>  
> Thanks for the test code.  Using your recipe, I confirmed I have the
> same controller as you.  Running on a dual PIII in my case.
> 
> Apparently Jens has a DAC as well.  Jens, is it the same?
> 
> -- 
> Daniel
