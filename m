Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSAPV53>; Wed, 16 Jan 2002 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289008AbSAPV5U>; Wed, 16 Jan 2002 16:57:20 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:23765 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289156AbSAPV5F>; Wed, 16 Jan 2002 16:57:05 -0500
Message-Id: <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Wed, 16 Jan 2002 16:31:44 EST." <20020116163144.D12306@thyrsus.com> 
Date: Wed, 16 Jan 2002 22:56:46 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
> Horst von Brand <brand@jupiter.cs.uni-dortmund.de>:
> > > Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> > > 	* Resync with 2.4.18-pre3 and 2.5.2.
> > > 	* It is now possible to declare explicit saveability predicates.
> > > 	* The `vitality' flag is gone from the language.  Instead, the 
> > > 	  autoprober detects the type of your root filesystem and forces
> > > 	  its symbol to Y.
> > 
> > Great! Now I can't configure a kernel for ext3 only on an ext2 box. Keep it
> > up! As it goes, we can safely forget about CML2...
> 
> Oh, nonsense.  You can do this just fine with any of the manual
> configurators.

Whatever happened to "Do exactly as CML1 does; leave fixes and extensions
for later"? If you put the kitchen sink into it, it _won't_ go into the
standard kernel.

> Now repeat after me, Horst:
> 
> 	The autoconfigurator is *optional*, not required.

It isn't "optional", it is builtin. It doesn't matter if somebody uses it
or nobody does, it will be there. And AFAIU what you have said, you are
modifiying CML2 (or at least the rulebase) for the sake of it. This is
_not_ what had been agreed on the matter.
-- 
Horst von Brand			     http://counter.li.org # 22616
