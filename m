Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbRGQPf2>; Tue, 17 Jul 2001 11:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266587AbRGQPfS>; Tue, 17 Jul 2001 11:35:18 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:28684 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S266586AbRGQPfM>;
	Tue, 17 Jul 2001 11:35:12 -0400
Date: Tue, 17 Jul 2001 08:35:14 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Shane Nay <shane@minirl.com>
Cc: James Simmons <jsimmons@transvirtual.com>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel] Re: [ANNOUNCE] Secondary mips tree.
Message-ID: <20010717083514.A19836@lucon.org>
In-Reply-To: <Pine.LNX.4.10.10107161226220.19188-100000@transvirtual.com> <0107170016150H.02677@compiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0107170016150H.02677@compiler>; from shane@minirl.com on Tue, Jul 17, 2001 at 12:16:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 12:16:15AM -0700, Shane Nay wrote:
> >   We have been having problems with toolchains as well. We plan to have a
> > new toolchain ready by Wednesday.
> 
> Yes, there have been a lot of toolchain issues with MIPs.  The last time I 
> went on a toolchain testing binge for MIPs was with GCC CVS in about April.  
> I had really good results with that toolchain with both the kernel and 
> userland.  I did some micro tests with 3.0 and they appeared solid, but I had 
> updated to the latest non-CVS version of bintools and it was chocking out 
> lots of assembler warnings when rebuilding glibc.  There are source and 
> binary snaps of that toolchain on the agenda FTP site under snow.
> 

The toolchain in my RedHat 7.1 mips port is as good as the x86 version
for RedHat 7.1. Since there is no mips maintainer for gcc, many
mips patches aren't reviewed. But they are in my mips toolchain.


H.J.
