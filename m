Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267680AbSLGAQf>; Fri, 6 Dec 2002 19:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbSLGAQf>; Fri, 6 Dec 2002 19:16:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11260 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267680AbSLGAQa>; Fri, 6 Dec 2002 19:16:30 -0500
Date: Sat, 7 Dec 2002 01:24:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: acpi-devel@sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Proposed ACPI Licensing change
Message-ID: <20021207002405.GR2544@fs.tum.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 04:10:00PM -0800, Grover, Andrew wrote:

> Hi all,

Hi Andrew,

>...
> One consequence of this is that we have not been able to benefit directly
> from patches from other Linux contributors. The reason is, patches submitted
> to code only under the GPL must also be GPL, and therefore we cannot take
> them directly and still make our code available under a license other than
> the GPL. (We have to determine the problem the patch fixes and then do the
> fix ourselves.)
>...
> In order to solve this, we are considering releasing the Linux version of
> the interpreter under a dual license. This would allow direct incorporation
> of changes. Any patches submitted against the ACPI core code would
> implicitly be allowed to be used by us in a non-GPL context. This is already
> done elsewhere in the Linux kernel source by the PCMCIA code, for example.
> 
> Comments?

two comments regarding the right of an author to freely choose under 
which license(s) he wants to make his patch available:

If a submitter wants to allow you to use his patch under both licenses 
he's already able to allow you to do so.

You can't forbid people to send GPL-only patches, so if a person doesn't
want his patch under your looser license you can't enforce that he also
releases it under your looser license.

> Regards -- Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

