Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKTRBh>; Wed, 20 Nov 2002 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKTRBh>; Wed, 20 Nov 2002 12:01:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42434 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261594AbSKTRBE>; Wed, 20 Nov 2002 12:01:04 -0500
Date: Wed, 20 Nov 2002 18:08:03 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Rus Foster <rghf@fsck.me.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patching 2.5.xx
Message-ID: <20021120170803.GD11952@fs.tum.de>
References: <20021120170131.D63367-100000@freebsd.rf0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120170131.D63367-100000@freebsd.rf0.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 05:03:30PM +0000, Rus Foster wrote:

> Hi All,

Hi Rus,

> I've decided to start trying out the 2.5 kernels and I've got the 2.5.47
> tarball and the 2.5.48 patch. However looking at the diff file its trying
> to create an a and b directory. Is there a special significance for this
> and how do I go about applying the patch?

  cd linux-2.5.47
  zcat ../patch-2.5.48.gz | patch -p1

> Rgds
> 
> Rus Foster

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

