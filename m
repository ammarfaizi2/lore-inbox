Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312408AbSDJCaL>; Tue, 9 Apr 2002 22:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSDJCaK>; Tue, 9 Apr 2002 22:30:10 -0400
Received: from pcp01314487pcs.hatisb01.ms.comcast.net ([68.63.220.2]:35211
	"EHLO bacchus.jdhouse.org") by vger.kernel.org with ESMTP
	id <S312408AbSDJCaJ>; Tue, 9 Apr 2002 22:30:09 -0400
Date: Tue, 9 Apr 2002 21:31:37 -0500 (CDT)
From: "Jonathan A. Davis" <davis@jdhouse.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radeon frame buffer driver
In-Reply-To: <20020410001249.GA2010@berserk.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0204092119280.2311-100000@bacchus.jdhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Peter Horton wrote:

> Another installment of the Radeon frame buffer driver patch (still
> against 2.4.19-pre2).
...
> 
> Driver seems okay now, plays nicely with X etc. etc. Please test if you
> can
>  

Patched it into 2.4.19-pre5-ac2 (minus the earlier radeon patches that I
chainsawed out several days ago :-).  Have been running for a few hours
now using console and X with a lot of switching back and forth.  Also
spent some time using xawtv and some fb goodies.  Played some tuxracer
just to be sure GL was okay.  All seems quite well with no problems to
report.

Hardware/Software:

ATI Radeon 7500/64MB
Athlon 1700+ VIA K266A
Redhat more/less 7.2.
XFree 4.2 (RH 4.2.0-6.52)

Thanks,

-- 

-Jonathan <davis@jdhouse.org>



