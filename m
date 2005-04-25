Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVDYUYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVDYUYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVDYUYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:24:38 -0400
Received: from colino.net ([213.41.131.56]:45554 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261162AbVDYUUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:20:50 -0400
Date: Mon, 25 Apr 2005 22:20:39 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.12-rc3 cpufreq compile error on ppc32
Message-ID: <20050425222039.5421fa64@jack.colino.net>
In-Reply-To: <1114129070.5996.36.camel@gaston>
References: <20050421092611.37df940b@colin.toulouse>
	<1114129070.5996.36.camel@gaston>
X-Mailer: Sylpheed-Claws 1.9.6cvs36 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2005 at 10h04, Benjamin Herrenschmidt wrote:

Hi, 

> > 
> > One of Ben's patches ("ppc32: Fix cpufreq problems") went in 2.6.12-
> > rc3, but it depended on another patch that's still in -mm only: 
> > add-suspend-method-to-cpufreq-core.patch
> > 
> > In addition to this, there's a third patch in -mm that fixes
> > warnings and line length to the previous patch, but it doesn't
> > apply cleanly anymore. It's named add-suspend-method-to-cpufreq-
> > core-warning-fix.patch
> 
> Yup, please, Andrew, get those 2 to Linus.

Just a heads-up : I didn't see these go into the git tree?

-- 
Colin
