Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132653AbRC2Ixo>; Thu, 29 Mar 2001 03:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132670AbRC2IxZ>; Thu, 29 Mar 2001 03:53:25 -0500
Received: from dexter.allieddomecq.ro ([212.93.128.30]:1029 "HELO
	mail.allieddomecq.ro") by vger.kernel.org with SMTP
	id <S132653AbRC2IxU>; Thu, 29 Mar 2001 03:53:20 -0500
Date: Thu, 29 Mar 2001 10:54:17 +0300 (EEST)
From: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: [WISHLIST] Addition of suspend patch into 2.5?
In-Reply-To: <20010222214308.B14395@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21md.0103291046060.2103-100000@dexter.allieddomecq.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a small adition to the 2.5 whislist:
Is "hibernation" on linux possible? Ideally it should write out on the /
running on ext2fs and the new journaling fs's like reiserfs, xfs, etx3 etc
and not some special filesystem or unpartiotioned space etc. I mean that
this should be working without the need to repartiotion/reinstall.
This is something **very** useful for laptop owners, not having to shut 
down (all) applications when need to grab the laptop and travel.
Id' like to see this working nice in 2.6.

Best regards,
r

On Thu, 22 Feb 2001, Pavel Machek wrote:

> Date: Thu, 22 Feb 2001 21:43:08 +0100
> From: Pavel Machek <pavel@suse.cz>
> To: Shawn Starr <spstarr@sh0n.net>, lkm <linux-kernel@vger.kernel.org>
> Subject: Re: [WISHLIST] Addition of suspend patch into 2.5?
> 
> Hi!
> 
> > Any idea if suspend/hybernation will be in future kernels?
> 
> I'd like it included, too. Some toshiba laptops support sleep but not
> suspend, and battery runs out within few hours if it was low before
> suspend. That's bad.
> 
> And the patch was pretty clean last time I checked.
> 								Pavel
> -- 
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

