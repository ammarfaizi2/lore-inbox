Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280655AbRKBL0Q>; Fri, 2 Nov 2001 06:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280657AbRKBL0F>; Fri, 2 Nov 2001 06:26:05 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:23248 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S280655AbRKBLZp>; Fri, 2 Nov 2001 06:25:45 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Chow <davidchow@rcn.com.hk>
Date: Fri, 2 Nov 2001 22:25:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15330.33436.410959.372796@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm documentation
In-Reply-To: message from David Chow on Friday November 2
In-Reply-To: <3BE242D4.AC94A544@rcn.com.hk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 2, davidchow@rcn.com.hk wrote:
> Dear all,
> 
> Is there any documentation of the recent changes of the vm in the linux
> kernel? Also, is there any source of documentation to get start with the
> linux kernel hacking? It is hard for people to getting start to
> contribute since is is obviously lack of documentation of the kernel
> sources... Any help will be appreciated. Thanks.
> 

I would very seriously suggest that a good way to get started is to
write some documentation yourself.

Pick a piece of the kernel that interests you and start reading
through the code.  Then try to describe how it works in writing.  If
there is some bit that really stumps you,. then ask on some
appropriate mailing list (such as this one).  Try to put together a
reasonably coherent document that describes how that bit of the kernel
works.  Once you have done that:
 a/ you will know how it works
 b/ you will have been exposed to lots of kernel code and have some
    idea of the 'typical' way to do things
 c/ you will probably have identified a number of incongurities or
    errors for which you can submit patches.
 d/ you will have created some documentation that is useful for
    others.
 e/ you will have lots of ideas about what to do next.

There is no easy way to just "start contributing".  You need to put a
lot of work in before your contributions will really be valuable.
Reading code is a great way to start, and documenting it makes sure
that you read it properly.

It's how I started.

NeilBrown
