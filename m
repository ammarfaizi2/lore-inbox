Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280823AbRKGP33>; Wed, 7 Nov 2001 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280821AbRKGP3T>; Wed, 7 Nov 2001 10:29:19 -0500
Received: from leeor.math.technion.ac.il ([132.68.115.2]:48282 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S280823AbRKGP3G>; Wed, 7 Nov 2001 10:29:06 -0500
Date: Wed, 7 Nov 2001 17:28:40 +0200 (IST)
From: "Zvi Har'El" <rl@math.technion.ac.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>,
        <nyh@math.technion.ac.il>
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0111071726260.2977-100000@leeor.math.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Alan Cox wrote:

> > I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
> > I see no difference at all. After a chrash, it really wants to run fsck
> > anyway. I've tried ReiserFS before, with no fsck after chrashes - is this
>
> Umm RH 7.2 after an unexpected shutdown will give you a 5 second count down
> when you can choose to force an fsck - ext3 doesnt need an fsck but
> sometimes folks might want to force it thats all

I get this countdown, but after 5 seconds fsck starts anyway, without me
hitting Y! Should I hit N, or should I change some config somewhere? Now each
time my battery runs out, I need fsck!

-- 
Dr. Zvi Har'El     mailto:rl@math.technion.ac.il     Department of Mathematics
tel:+972-54-227607                   Technion - Israel Institute of Technology
fax:+972-4-8324654 http://www.math.technion.ac.il/~rl/     Haifa 32000, ISRAEL
"If you can't say somethin' nice, don't say nothin' at all." -- Thumper (1942)
                         Wednesday, 21 Heshvan 5762,  7 November 2001,  5:26PM

