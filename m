Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133081AbRDLI6z>; Thu, 12 Apr 2001 04:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133079AbRDLI6p>; Thu, 12 Apr 2001 04:58:45 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:40712 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S133078AbRDLI61>;
	Thu, 12 Apr 2001 04:58:27 -0400
Date: Thu, 12 Apr 2001 10:57:33 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010412105733.E25536@pcep-jamie.cern.ch>
In-Reply-To: <200104101047.f3AAl0h07395@snark.thyrsus.com> <200104120709.f3C798Y426000@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104120709.f3C798Y426000@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, Apr 12, 2001 at 03:09:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> > * All three interfaces do progressive disclosure -- the user only sees
> >   questions he/she needs to answer (no more hundreds of greyed-out menu
> >   entries for irrelevant drivers!).
> 
> Well, that sucks. The greyed-out menu entries were the only good
> thing about xconfig. Such entries provide a clue that you need
> to enable something else to get the feature you desire. Otherwise
> you might figure that the feature is missing, or that you have
> overlooked it.

I agree.  I use menuconfig and it's pretty good, but sometimes I miss
the ability to go through all the available options and decide, one by
one, whether I want to enable the option.

Of course if I do not enable some PCI NIC driver, I do not need to see
special options for that driver.  That's good.  On the other hand, if I
am looking to enable RED, I won't realise that I need to enable
traffic shaping first to discover the RED option.

-- Jamie
