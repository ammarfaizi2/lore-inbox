Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSLPRQB>; Mon, 16 Dec 2002 12:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbSLPRQB>; Mon, 16 Dec 2002 12:16:01 -0500
Received: from rivmkt61.wintek.com ([206.230.0.61]:128 "EHLO comcast.net")
	by vger.kernel.org with ESMTP id <S266886AbSLPRP7>;
	Mon, 16 Dec 2002 12:15:59 -0500
Date: Mon, 16 Dec 2002 12:11:58 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52 and modules (lots of unresolved symbols)?
In-Reply-To: <20021216171703.GD13198@ulima.unil.ch>
Message-ID: <Pine.LNX.4.50L0.0212161207430.1154-100000@dust.ebiz-gw.wintek.com>
References: <20021216094514.GA735@ulima.unil.ch>
 <Pine.LNX.4.50L0.0212161114360.1154-100000@dust.ebiz-gw.wintek.com>
 <20021216171703.GD13198@ulima.unil.ch>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Gregoire Favre wrote:

> On Mon, Dec 16, 2002 at 11:19:00AM +0000, Alex Goddard wrote:
> 
> > > I have just patched 2.5.51, and not done the make clean && make mrproper
> > > before doing a make menuconfig && make dep && make bzImage && make
> > > modules...
> > > 
> > > Will that change anything to make clean/mrproper here?
> > 
> > I would give 'make clean' a try.
> 
> I am just doing that right now... I'll wait till completion to report
> the issue:
> 
> No change, still the same messages :-(

Huh.  Like I said, reinstalling the mod tools and doing a rebuild after a 
make clean cleared it up for me.

Weird.

> Thank you very much and have a great day,

You too.

-- 
Alex Goddard
agoddard@purdue.edu
