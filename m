Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292505AbSBUVFg>; Thu, 21 Feb 2002 16:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292772AbSBUVF0>; Thu, 21 Feb 2002 16:05:26 -0500
Received: from zok.SGI.COM ([204.94.215.101]:34272 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292505AbSBUVFR>;
	Thu, 21 Feb 2002 16:05:17 -0500
Date: Thu, 21 Feb 2002 13:05:08 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Erich Focht <focht@ess.nec.de>
cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.LNX.4.21.0202211154190.12765-100000@sx6.ess.nec.de>
Message-ID: <Pine.SGI.4.21.0202211301170.561412-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I can't claim to entirely understand Ingo's latest changes
for cpus_allowed and migration, but it seems that Erich managed
to provoke Ingo into coming up with something that likely meets
my modest needs and then some.

If this sticks, then good.  Mission accomplished.

Thanks Ingo, Erich, Kimio, Robert, ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

