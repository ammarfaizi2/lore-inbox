Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313771AbSDQJle>; Wed, 17 Apr 2002 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313815AbSDQJld>; Wed, 17 Apr 2002 05:41:33 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:12028 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313771AbSDQJlc>; Wed, 17 Apr 2002 05:41:32 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, vojtech@suse.cz,
        rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Date: Wed, 17 Apr 2002 02:39:35 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <3CBD2847.6010003@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0204170237120.389-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Martin Dalecki wrote:

> > Now, the problem of dealing with DMA along with the swapping is
> > something scary. I beleive the sanest solution that won't please
> > affected people is to _not_ support DMA on these broken HW ;)
>
> No: the sane sollution would be to not support swapping disks between
> those systems and other systems.

in this case please send me a system compatable with my tivo so that I can
hack on it since you are telling me I'm not going to be able to swap disks
between it and any sane system.

doing without DMA is very reasonable and not a significant problem (yes it
slows me down if I am duplicating drives, but if I am mounting the drive
so that I can go in and vi the startup files the speed difference doesn't
matter)

David Lang
