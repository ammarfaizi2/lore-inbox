Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289294AbSAVM7H>; Tue, 22 Jan 2002 07:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSAVM66>; Tue, 22 Jan 2002 07:58:58 -0500
Received: from ns.suse.de ([213.95.15.193]:6162 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289294AbSAVM6p>;
	Tue, 22 Jan 2002 07:58:45 -0500
Date: Tue, 22 Jan 2002 13:58:43 +0100
From: Dave Jones <davej@suse.de>
To: Shaya Potter <spotter@opus.cs.columbia.edu>
Cc: Steve Brueggeman <brewgyman@mediaone.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122135843.B16444@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Shaya Potter <spotter@opus.cs.columbia.edu>,
	Steve Brueggeman <brewgyman@mediaone.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com>, <20020121.053724.124970557.davem@redhat.com>; <20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au> <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com> <1011678359.904.4.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1011678359.904.4.camel@zaphod>; from spotter@opus.cs.columbia.edu on Tue, Jan 22, 2002 at 12:45:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 12:45:59AM -0500, Shaya Potter wrote:
 > athlon XP 1800 is a cpuid 622 (aka an A5)
 > at least my 2 XP 1800+s are 622, so I assume all are (could be wrong)

 Unless you have /proc/cpuinfo output that says otherwise, this is
 wrong. 622 is the olde Athlon (0.18um) Rev A2.

 XP is 662 with cachesize >=256 with bit 19 of capflags==0

 (Determining new Duron/Athlon XP/Athlon MP is quite messy,
  see x86info source for gory details)
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
