Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135679AbRDSOYo>; Thu, 19 Apr 2001 10:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135680AbRDSOYe>; Thu, 19 Apr 2001 10:24:34 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:17930 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135679AbRDSOYX>;
	Thu, 19 Apr 2001 10:24:23 -0400
Date: Thu, 19 Apr 2001 10:25:08 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419102508.A426@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010418233445.A28628@thyrsus.com> <20010419090220.A2291@flint.arm.linux.org.uk> <20010419091623.D31701@thyrsus.com> <3ADEF360.45B4F4E8@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADEF360.45B4F4E8@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 19, 2001 at 10:17:04AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> "Eric S. Raymond" wrote:
> > CONFIG_SOUND_YMPCI: arch/ppc/configs/power3_defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/lart arch/arm/def-configs/shark
> 
> typo, that should be ...YMFPCI.
> 
> maybe you could add soundex to catch misspellings ;-)

Don't laugh.  I considered it -- only not with soundex but with 
Ratcliff/Obershelp gestalt similarity matching, which is better at
catching this sort of typo.  Python has a module for this; I could make
it happen with about two hours' work.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You need only reflect that one of the best ways to get yourself 
a reputation as a dangerous citizen these days is to go about 
repeating the very phrases which our founding fathers used in the 
great struggle for independence.
	-- Attributed to Charles Austin Beard (1874-1948)
