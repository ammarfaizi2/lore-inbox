Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311646AbSCNQQr>; Thu, 14 Mar 2002 11:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311649AbSCNQQi>; Thu, 14 Mar 2002 11:16:38 -0500
Received: from ns.suse.de ([213.95.15.193]:13064 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311646AbSCNQQV>;
	Thu, 14 Mar 2002 11:16:21 -0500
Date: Thu, 14 Mar 2002 17:16:20 +0100
From: Dave Jones <davej@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020314171620.I19636@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrea Arcangeli <andrea@suse.de>, Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020314133223.B19636@suse.de> <Pine.LNX.3.96.1020314104230.9248A-100000@gatekeeper.tmr.com> <20020314171259.I22054@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314171259.I22054@dualathlon.random>; from andrea@suse.de on Thu, Mar 14, 2002 at 05:12:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 05:12:59PM +0100, Andrea Arcangeli wrote:
 > Correct. I think the CONFIG option isn't worthwhile in the first place
 > and this is why I only left the CONFIG_M686 knowing most smp kernels are
 > compiled that way.  4096bytes of virtual vmallc space and some houndred
 > bytes of bytecode doesn't worth the config option. If something the
 > CONFIG_F00F would be more a documentation effort 8).
 
 nononono! CONFIG_FOOF is a derived symbol from whatever CONFIG_Mx8x
 is set. Much in the way we derive CONFIG_X86_WP_WORKS_OK, CONFIG_X86_PPRO_FENCE
 and freinds.. 
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
