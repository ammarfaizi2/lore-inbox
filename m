Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280457AbRKNLG6>; Wed, 14 Nov 2001 06:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280460AbRKNLGs>; Wed, 14 Nov 2001 06:06:48 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:2014 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S280457AbRKNLGf>; Wed, 14 Nov 2001 06:06:35 -0500
Date: Wed, 14 Nov 2001 12:04:48 +0100 (CET)
From: kees <kees@schoen.nl>
To: J Sloan <jjs@pobox.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: report: tun device
In-Reply-To: <3BF23D21.B8F356DA@pobox.com>
Message-ID: <Pine.LNX.4.33.0111141157530.5740-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, J Sloan wrote:

> kees wrote:
>
> > Hi,
> >
> > answers:
> >
> > 1) vtun-2.5b1.tar.gz
> > 2) none, it was the first time I build and tried to run it
>
> Ah, now we are getting somewhere.
>
> 2 more questions to round out the info:
>
> Are you running a distro that ships kernel

I'm running  SuSE 7.2 but the kernel I downloaded recently


> headers separately from the kernel itself?
> Most distros do nowdays - and if so, do
> you perhaps have an old kernel headers
> package installed? (like the original)
I would have sworn  <-------!!!!

 that /usr/include/linux had pointed to
/usr/src/linux/include/linux
and /usr/include/asm to /usr/src/linux/include/asm-i386

BUT   THEY DON'T!!

blush blush, it must have been changed back while upgrading from
SuSE 7.0 to SuSE 7.2

I will revert it and test again.

thanks

Kees



>
> BTW what distro is it, if I may ask?
>
> cu
>
> jjs
>

