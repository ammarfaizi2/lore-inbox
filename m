Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbSAVPa4>; Tue, 22 Jan 2002 10:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSAVPaq>; Tue, 22 Jan 2002 10:30:46 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:43281 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S287141AbSAVPag>;
	Tue, 22 Jan 2002 10:30:36 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Shaya Potter <spotter@cs.columbia.edu>
To: Dave Jones <davej@suse.de>
Cc: Steve Brueggeman <brewgyman@mediaone.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020122135843.B16444@suse.de>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com>,
	<20020121.053724.124970557.davem@redhat.com>;
	<20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au>
	<o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
	<1011678359.904.4.camel@zaphod>  <20020122135843.B16444@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Jan 2002 10:27:35 -0500
Message-Id: <1011713259.904.6.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you're right, it's a typo on my part.  I hit 2 twice instead of 6.

woops

On Tue, 2002-01-22 at 07:58, Dave Jones wrote:
> On Tue, Jan 22, 2002 at 12:45:59AM -0500, Shaya Potter wrote:
>  > athlon XP 1800 is a cpuid 622 (aka an A5)
>  > at least my 2 XP 1800+s are 622, so I assume all are (could be wrong)
> 
>  Unless you have /proc/cpuinfo output that says otherwise, this is
>  wrong. 622 is the olde Athlon (0.18um) Rev A2.
> 
>  XP is 662 with cachesize >=256 with bit 19 of capflags==0
> 
>  (Determining new Duron/Athlon XP/Athlon MP is quite messy,
>   see x86info source for gory details)
>  
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
-- 
spotter@{cs.columbia.edu,yucs.org}
http://yucs.org/~spotter/

