Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWHRXLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWHRXLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWHRXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:11:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52233 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751374AbWHRXLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:11:16 -0400
Date: Sat, 19 Aug 2006 01:11:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060818231115.GC7813@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org> <20060818224814.GA10524@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818224814.GA10524@openwall.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 02:48:14AM +0400, Solar Designer wrote:
> Hi Willy,
> 
> On Wed, Aug 16, 2006 at 10:36:33PM +0000, Willy Tarreau wrote:
> > Also, I've been asked by several people to consider merging Mikael
> > Pettersson's gcc4 patches :
> > 
> >    http://user.it.uu.se/~mikpe/linux/patches/2.4/
> > 
> > I've been reluctant at first for the usual reasons : "who has a 2.4
> > distro with gcc4 ?" ...
> 
> We're about to migrate Openwall GNU/*/Linux (Owl) from its current gcc
> 3.4.5 (which we used in our 2.0 release) to gcc 4+ - and we'd rather
> _not_ migrate to Linux 2.6 at the same time, if we can.  We'd be more
> comfortable migrating to Linux 2.6 a few months later.
>...

Considering that it's really easy to compile the kernel with a different 
compiler than the userland, do you _really_ want to use such a 
relatively untested kernel/gcc combination for a server platform?

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

