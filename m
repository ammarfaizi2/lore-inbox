Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSHRERH>; Sun, 18 Aug 2002 00:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318844AbSHRERH>; Sun, 18 Aug 2002 00:17:07 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:22404 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S318839AbSHRERG>; Sun, 18 Aug 2002 00:17:06 -0400
Date: Sun, 18 Aug 2002 14:20:47 +1000
From: CaT <cat@zip.com.au>
To: Scott Bronson <bronson@rinspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?  IDE-TNG driver
Message-ID: <20020818042046.GI18855@zip.com.au>
References: <Pine.LNX.4.44.0208172353330.3111-100000@sharra.ivimey.org> <1029630519.1541.11.camel@emma> <1029642451.1599.2.camel@emma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029642451.1599.2.camel@emma>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:47:30PM -0700, Scott Bronson wrote:
> > Everyone I've heard advocating a moduleless kernel uses an argument that
> > boils down to "it's slightly more secure."  Does anybody have a GOOD
> > reason for not using modules?  Obsolete or embedded hardware arguments
> > don't count.
> 
> Someone replied off-list saying that initrds are too hard to create.
> 
> That's true.  They are.  One day, hopefully that will change.
> 
> Any other reasons?

Because I shouldn't have to use a feature if I don't need to use a
feature?

I dunno... I've not once heard a decent argument as to why I should
modulerise the ide subsystem, or ext3 or the video drivers and so on.

Where I -do- need to use it though, I do happily use it. One case is to
reset the eepro100 driver so that it works after my computer is brought
out of suspend mode (either RAM or disk).

But why should I -not- make a monolithic kernel when I don't have any
reason to do so? If you can provide me with some decent ones, I'll
happily start...

-- 
   "There was a moo from under the blanket, and I knew it was not a person,
   but a calf."
         - http://www.iol.co.za/index.php?art_id=qw1028795041273B265
