Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRDSRRG>; Thu, 19 Apr 2001 13:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRDSRQ6>; Thu, 19 Apr 2001 13:16:58 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:39690 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131481AbRDSRQp>;
	Thu, 19 Apr 2001 13:16:45 -0400
Date: Thu, 19 Apr 2001 13:17:38 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Good example of the kind of thing the cross-referencer turns up.
Message-ID: <20010419131738.A2970@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Go on.  Tell me this isn't an error...

CONFIG_ARCH_CLPS7110: arch/arm/kernel/arch.c
CONFIG_ARCH_CLPS711X: arch/arm/Makefile arch/arm/config.in arch/arm/kernel/Makefile arch/arm/kernel/entry-armv.S arch/arm/kernel/debug-armv.S arch/arm/def-configs/ebsa110 arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/integrator

Somebody forgot an edit.  I wonder what bits got permanently conditioned out?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The great object is, that every man be armed. [...] 
Every one who is able may have a gun."
        -- Patrick Henry, speech of June 14 1788
