Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSKLKmm>; Tue, 12 Nov 2002 05:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266508AbSKLKmm>; Tue, 12 Nov 2002 05:42:42 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51860 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266464AbSKLKml>;
	Tue, 12 Nov 2002 05:42:41 -0500
Date: Tue, 12 Nov 2002 10:46:50 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ian Molton <spyro@f2s.com>
Cc: Alexander Viro <viro@math.psu.edu>, xavier.bestel@free.fr,
       linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-ID: <20021112104650.GA322@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ian Molton <spyro@f2s.com>, Alexander Viro <viro@math.psu.edu>,
	xavier.bestel@free.fr, linux-kernel@vger.kernel.org
References: <1037094221.16831.21.camel@bip> <Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu> <20021112102535.1f94f50d.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112102535.1f94f50d.spyro@f2s.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 10:25:35AM +0000, Ian Molton wrote:
 > > 	Again, WE ARE IN FEATURE FREEZE.
 > And since when did feature freeze affect, as the guy said, *purely*
 > userspace implementations?

 Since it would a *feature* to move it out of kernel space.
 To reiterate : _FEATURE_ _FREEZE_. Nothing[1] new[2]
 should be going into mainline at this point.

 We should now be in the stabilising period, where we don't require
 testers to have to upgrade their userspace every fortnight.

		Dave

[1] Rusty's modules rewrite and whatever else Linus queed up
    seems to have exemption from this rule. Hopefully there
    isn't too much of this stuff.
[2] Where 'new' can also mean 'bloody large reimplementation'
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
