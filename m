Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRKAArE>; Wed, 31 Oct 2001 19:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277097AbRKAAqy>; Wed, 31 Oct 2001 19:46:54 -0500
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:10249 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S276982AbRKAAqo>;
	Wed, 31 Oct 2001 19:46:44 -0500
Date: Wed, 31 Oct 2001 16:49:44 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: J Sloan <jjs@pobox.com>
cc: Ville Herva <vherva@niksula.hut.fi>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <3BE07D05.3B71B67D@pobox.com>
Message-ID: <Pine.LNX.4.10.10110311642060.7849-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, J Sloan wrote:

> Vile Hernia wrote:
> 
> > BTW, on win95 the HZ is 1024, which caused it to _always_ crash if it ever
> > reached 48.5 days of uptime. I've seen NT4 SMP to to crash at same point as
> > well (though it doesn't do it always).
> 
> It's funny that windoze went for years
> without anybody ever realizing about
> the 49 day crash - heck, one crash
> every 49 days is lost in the noise on
> a windoze pee cee - no wonder they
> never noticed.
> 
> OTOH, when our Linux uptimes went back
> to zero at 497 days, I noticed immediately,
> and screamed bloody murder until I found
> it was just a timer wraparound.
> 
Seems to be a cultural diffrence between windows and linux users.

Probably something for ESR or whoever to do a paper on ;)

        Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

