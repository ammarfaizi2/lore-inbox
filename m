Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279425AbRJZVzX>; Fri, 26 Oct 2001 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279443AbRJZVzE>; Fri, 26 Oct 2001 17:55:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38924 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279441AbRJZVyx>; Fri, 26 Oct 2001 17:54:53 -0400
Date: Fri, 26 Oct 2001 23:54:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: Marcos Dione <mdione@hal.famaf.unc.edu.ar>, linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
Message-ID: <20011026235447.A23218@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar> <20011025161330.A38@toy.ucw.cz> <20011026192750.A670@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011026192750.A670@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 	One thing I thought: how is this supposed to work on laptops? can
> > > they be suspended? a question related to this one: I also have ACPI turned
> > > on and APM turned off. how can I switch to stanby states? is there a way?
> > > again, how does it works on laptops?
> > 
> > I'm working on suspend-to-disk, and suspend-to-ram is mostly working, also.
> > ...
> 
> Sweet.
> 
> What's not working with suspend-to-ram? Gateway, in their infinate

Patrick Mochel from transmeta. [Or you meant suspend-to-disk?]

> wisdon, nuked suspend-to-disk functionality of the bios in the most
> recent edition (which they kindly upgraded me to when I put my laptop
> in for servicing...). As such I only have suspend-to-ram working and
> I'm also interested in playing with ACPI.

								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
