Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTBDMQI>; Tue, 4 Feb 2003 07:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbTBDMQI>; Tue, 4 Feb 2003 07:16:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22510 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267243AbTBDMQI>; Tue, 4 Feb 2003 07:16:08 -0500
Date: Tue, 4 Feb 2003 13:25:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204122536.GV6915@fs.tum.de>
References: <Pine.LNX.3.95.1030203182417.7651A-100000@chaos.analogic.com> <200302040656.h146uJs10531@Port.imtp.ilyichevsk.odessa.ua> <162450000.1044342810@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162450000.1044342810@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 11:13:31PM -0800, Martin J. Bligh wrote:
> > I'm afraid it's code generation engine. It is just worse than
> > M$ or Intel's one. It is not easily fixable,
> > GCC folks have tremendous task at hand.
> > 
> > I wonder whether some big companies supposedly supporting 
> > Linux (e.g. Intel) can help GCC team (for example by giving
> > away some code and/or developer time).
> 
> Comparing Intel's compiler vs GCC on Linux would be more interesting.
> Anyone got a copy and some time to burn?

There are already people who have done this, e.g.

  http://www.coyotegulch.com/reviews/intel_comp/intel_gcc_bench2.html

compares g++ and Intel's C++ compiler with C++ code.

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

