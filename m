Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275398AbTHIUT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275399AbTHIUT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:19:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19141 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275398AbTHIUT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:19:58 -0400
Date: Sat, 9 Aug 2003 22:19:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ville Herva <vherva@niksula.cs.hut.fi>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, gibbs@scsiguy.com, alan@redhat.com
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1, aic7xxx-6.2.36: solid hangs)
Message-ID: <20030809201951.GP16091@fs.tum.de>
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030808125502.GB150921@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808125502.GB150921@niksula.cs.hut.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 03:55:02PM +0300, Ville Herva wrote:
>...
> Ok, the kernel compiled with gcc version 3.2.1 20021207 (Red Hat Linux 8.0
> 3.2.1-2) has now been up for more than a week. It seems stable, but I'm not
> sure yet.
> 
> Which brings me to the question: which gcc version is considered most stable
> for compiling 2.4.x these days?
>...
> This seems to suggest 2.96-85 would be more stable than gcc-3.2.1-2. Is this
> the case?
>...

2.95.3 and the (unofficial) 2.96 are the best compilers for 2.4 .

In most cases 3.2.1 will give you a working kernel, but if you need
maximum stablity don't use gcc 3.x for compiling kernel 2.4 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

